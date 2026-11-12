import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeptrack/src/common_widget/styled_dropdown.dart';
import 'package:keeptrack/src/common_widget/styled_text.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/src/features/circuit/domain/circuit.dart';
import 'package:keeptrack/src/features/circuit/presentation/circuit_detail/modal_bottom_sheet/add_button.dart';
import 'package:keeptrack/src/features/circuit/presentation/circuit_detail/modal_bottom_sheet/lap_time_formatter.dart';
import 'package:keeptrack/src/features/user/data/local/fake_users_repository.dart';
import 'package:keeptrack/src/features/user/domain/user.dart';
import 'package:keeptrack/src/features/voiture/data/remote/nodejs_voitures_repository.dart';
import 'package:keeptrack/src/features/voiture/domain/voiture.dart';
import 'package:keeptrack/theme/theme.dart';

class BottomSheetAddVoiture extends ConsumerStatefulWidget {
  const new(this.currentUser, this.circuit, {super.key});

  final User currentUser;
  final Circuit circuit;

  @override
  ConsumerState<BottomSheetAddVoiture> createState() =>
      _BottomSheetAddCarState();
}

class _BottomSheetAddCarState extends ConsumerState<BottomSheetAddVoiture> {
  String? selectedBrand;
  String? selectedVoiture;

  int nombreDeTemps = 1;

  final List<TextEditingController> _tempsControllers = [
    TextEditingController(),
  ];

  void _ajouterTemps() {
    setState(() {
      nombreDeTemps++;
      _tempsControllers.add(TextEditingController());
    });
  }

  @override
  void dispose() {
    for (final controller in _tempsControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addPerformance(List<Voiture> voitures) {
    if (selectedBrand == null || selectedVoiture == null) return;

    final tempsList = _tempsControllers
        .map((controller) => controller.text)
        .where((temps) => temps.isNotEmpty)
        .toList();

    if (tempsList.isEmpty) return;

    final voitureSelectionnee = voitures.firstWhere(
      (voiture) => voiture.name == selectedVoiture,
    );

    ref
        .read(fakeUsersRepositoryProvider)
        .addUserPerformance(
          userId: widget.currentUser.id!,
          circuit: widget.circuit,
          voiture: voitureSelectionnee,
          temps: tempsList,
        );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final voituresAsync = ref.watch(voituresListFutureProvider);

    return voituresAsync.when(
      loading: () => Container(
        height: Sizes.p900,
        decoration: BoxDecoration(
          color: AppColors.bottomSheetColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Sizes.p24),
            topRight: Radius.circular(Sizes.p24),
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Container(
        height: Sizes.p900,
        decoration: BoxDecoration(
          color: AppColors.bottomSheetColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Sizes.p24),
            topRight: Radius.circular(Sizes.p24),
          ),
        ),
        child: const Center(child: Text('Erreur de chargement des voitures')),
      ),
      data: (voitures) {
        final brands = voitures
            .where((voiture) => voiture.brand != null)
            .map((voiture) => voiture.brand!)
            .toSet()
            .toList();

        final voitureNames = voitures
            .where((voiture) => voiture.brand == selectedBrand)
            .map((voiture) => voiture.name)
            .toList();

        return Container(
          height: Sizes.p900,
          decoration: BoxDecoration(
            color: AppColors.bottomSheetColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Sizes.p24),
              topRight: Radius.circular(Sizes.p24),
            ),
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.p16,
                  horizontal: Sizes.p12,
                ),
                child: Column(
                  mainAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        StyledText("Ajouter un Temp", fontSize: Sizes.p16),
                      ],
                    ),
                    SizedBox(
                      width: Sizes.p72,
                      child: Divider(
                        thickness: 2.0,
                        color: AppColors.dividerColor,
                      ),
                    ),
                    gapH24,
                    StyledDropdown(
                      label: "marque",
                      values: brands,
                      initialSelection: brands.isNotEmpty ? brands.first : null,
                      onSelected: (value) {
                        setState(() {
                          selectedBrand = value;
                          selectedVoiture = null;
                        });
                      },
                    ),
                    gapH16,
                    StyledDropdown(
                      key: ValueKey(selectedBrand),
                      label: "voiture",
                      values: voitureNames.whereType<String>().toList(),
                      enabled: selectedBrand != null,
                      onSelected: (value) {
                        setState(() => selectedVoiture = value);
                      },
                    ),
                    gapH20,
                    Row(
                      children: [
                        StyledText("Temps", fontSize: Sizes.p16),
                        Expanded(child: SizedBox(width: 0)),
                        IconButton(
                          onPressed: _ajouterTemps,
                          icon: Icon(Icons.add, color: AppColors.textColor),
                        ),
                      ],
                    ),
                    ...List.generate(nombreDeTemps, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
                        child: TextFormField(
                          controller: _tempsControllers[index],
                          inputFormatters: [LapTimeFormatter()],
                          style: TextStyle(color: AppColors.textColor),
                          decoration: InputDecoration(
                            hintText: "1:23.456",
                            hintStyle: TextStyle(color: AppColors.inputHint),
                            labelText: "Tour ${index + 1}",
                            labelStyle: TextStyle(color: AppColors.inputLabel),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.inputHint,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    gapH32,
                    AddButton(onPressed: () => _addPerformance(voitures)),
                    gapH20,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
