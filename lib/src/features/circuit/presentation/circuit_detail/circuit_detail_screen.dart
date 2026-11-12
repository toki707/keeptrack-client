import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeptrack/src/common_widget/app_background.dart';
import 'package:keeptrack/src/common_widget/my_app_bar.dart';
import 'package:keeptrack/src/common_widget/section_title.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/src/features/circuit/data/remote/nodejs_circuits_repository.dart';
import 'package:keeptrack/src/features/circuit/presentation/circuit_detail/car_result_card.dart';
import 'package:keeptrack/src/features/circuit/presentation/circuit_detail/circuit_infos.dart';
import 'package:keeptrack/src/features/circuit/presentation/circuit_detail/modal_bottom_sheet/bottom_sheet_add_voiture.dart';
import 'package:keeptrack/src/features/circuit/presentation/circuit_detail/track_pres.dart';
import 'package:keeptrack/src/features/user/data/remote/nodejs_users_repository.dart';
import 'package:keeptrack/src/features/user/domain/voiture_performance.dart';
import 'package:keeptrack/theme/theme.dart';

class CircuitDetailScreen extends ConsumerWidget {
  const CircuitDetailScreen(this.circuitId, {super.key});

  final String circuitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final circuitsAsync = ref.watch(circuitsListFutureProvider);
    final usersAsync = ref.watch(usersListFutureProvider);

    return circuitsAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) => const Scaffold(
        body: Center(child: Text('Erreur de chargement du circuit')),
      ),
      data: (circuits) {
        final circuit = ref
            .read(nodejsCircuitsRepositoryProvider)
            .fetchCircuitById(circuitId);

        return usersAsync.when(
          loading: () =>
              Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (error, stackTrace) => Scaffold(
            body: Center(child: Text('Erreur de chargement de l’utilisateur')),
          ),
          data: (users) {
            if (users.isEmpty) {
              return const Scaffold(
                body: Center(child: Text('Aucun utilisateur disponible')),
              );
            }

            final currentUser = users.first;

            final List<VoiturePerformance> voituresDuCircuit = currentUser
                .performances
                .where((performance) => performance.circuit.name == circuit.name)
                .expand((performance) => performance.voitures)
                .toList();

            return Scaffold(
              body: AppBackground(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: Sizes.p232,
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    begin: .topCenter,
                                    end: .bottomCenter,
                                    colors: [Colors.black, Colors.transparent],
                                    stops: [0, 1.0],
                                  ).createShader(bounds);
                                },
                                blendMode: BlendMode.dstIn,
                                child: Image.asset(
                                  circuit.preview!,
                                  fit: .cover,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: .start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: .topCenter,
                                      end: .bottomCenter,
                                      colors: [
                                        AppColors.headerShadow,
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.p16,
                                    vertical: Sizes.p12,
                                  ),
                                  child: MyAppBar(circuit: circuit),
                                ),
                                gapH12,
                                TrackPres(circuit),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.p16,
                          ),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              CircuitCaracteristiques(circuit),
                              gapH20,
                              SectionTitle(
                                "Temps realises :",
                                trailing: IconButton.outlined(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      AppColors.addIconButton,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.add,
                                    color: AppColors.textColor,
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      barrierColor: Colors.transparent,
                                      builder: (BuildContext context) {
                                        return BottomSheetAddVoiture(
                                          currentUser,
                                          circuit,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              ...voituresDuCircuit
                                  .map(
                                    (voiturePerformance) => Padding(
                                      padding: const EdgeInsets.only(
                                        top: Sizes.p8,
                                      ),
                                      child: CarResultCard(voiturePerformance),
                                    ),
                                  )
                                  .toList()
                                  .reversed,
                              gapH12,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
