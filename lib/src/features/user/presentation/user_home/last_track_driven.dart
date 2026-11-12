import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keeptrack/src/common_widget/flag_avatar.dart';
import 'package:keeptrack/src/common_widget/styled_text.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/src/features/circuit/data/remote/nodejs_circuits_repository.dart';
import 'package:keeptrack/src/features/circuit/domain/circuit.dart';
import 'package:keeptrack/theme/theme.dart';

class LastTrackDriven extends ConsumerWidget {
  const LastTrackDriven(this.circuit, {super.key});

  final Circuit circuit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final circuitsAsync = ref.watch(circuitsListFutureProvider);

    return GestureDetector(
      onTap: () {
        if (!circuitsAsync.hasValue) return;

        final circuitComplet = ref
            .read(nodejsCircuitsRepositoryProvider)
            .fetchCircuitByName(circuit.name);

        context.goNamed(
          "circuitDetail",
          pathParameters: {'id': circuitComplet.id!},
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.p4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.p16),
          child: Container(
            height: Sizes.p120,
            width: Sizes.p400,
            decoration: BoxDecoration(
              color: AppColors.trackCardColor,
              border: Border.all(color: AppColors.trackCardBorder, width: 2),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  circuit.preview!,
                  fit: BoxFit.cover,
                  alignment: Alignment.centerLeft,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.0, 0.4, 0.8],
                      colors: [
                        Colors.transparent,
                        AppColors.trackGradientMiddle,
                        AppColors.trackGradientEnd,
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    gapW12,
                    Column(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Sizes.p24,
                          child: FlagAvatar(circuit.location, radius: Sizes.p12),
                        ),
                        Image.asset(circuit.outline!, height: Sizes.p72),
                      ],
                    ),
                    gapW16,
                    Column(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Sizes.p148,
                          child: StyledText(circuit.name!, maxLines: 2),
                        ),
                        SizedBox(
                          width: Sizes.p148,
                          child: StyledText(
                            "${circuit.country}, ${circuit.city}",
                            fontSize: Sizes.p8,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
