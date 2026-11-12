import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeptrack/src/common_widget/styled_text.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/src/features/circuit/data/remote/nodejs_circuits_repository.dart';
import 'package:keeptrack/src/features/circuit/presentation/list_circuits/circuit_card.dart';
import 'package:keeptrack/theme/theme.dart';

class ListCircuitsScreen extends ConsumerStatefulWidget {
  const ListCircuitsScreen({super.key});

  @override
  ConsumerState<ListCircuitsScreen> createState() => _ListCircuitsScreenState();
}

class _ListCircuitsScreenState extends ConsumerState<ListCircuitsScreen> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final circuitsAsync = ref.watch(circuitsListFutureProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: circuitsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: StyledText(
            'Erreur de chargement des circuits',
            fontSize: Sizes.p16,
          ),
        ),
        data: (circuits) {
          final displayedCircuits = _searchText.isEmpty
              ? circuits
              : circuits
                    .where(
                      (circuit) => circuit.name!.toLowerCase().contains(
                        _searchText.toLowerCase(),
                      ),
                    )
                    .toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(Sizes.p8),
                child: SearchBar(
                  hintText: "Rechercher...",
                  hintStyle: WidgetStatePropertyAll(
                    TextStyle(color: AppColors.searchHint, fontSize: Sizes.p12),
                  ),
                  leading: Icon(Icons.search, color: AppColors.searchHint),
                  backgroundColor: WidgetStatePropertyAll(
                    AppColors.searchBackground,
                  ),
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(color: AppColors.textColor, fontSize: Sizes.p12),
                  ),
                  shadowColor: WidgetStatePropertyAll(Colors.transparent),
                  side: WidgetStatePropertyAll(
                    BorderSide(color: AppColors.searchBorder, width: 2),
                  ),
                  onChanged: (text) {
                    setState(() {
                      _searchText = text;
                    });
                  },
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
                  itemCount: displayedCircuits.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: Sizes.p12,
                    mainAxisSpacing: Sizes.p12,
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (context, index) {
                    final circuit = displayedCircuits[index];
                    return CircuitCard(circuit);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
