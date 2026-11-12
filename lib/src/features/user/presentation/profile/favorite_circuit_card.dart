import 'package:flutter/material.dart';
import 'package:keeptrack/src/common_widget/styled_text.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/src/features/circuit/domain/circuit.dart';
import 'package:keeptrack/theme/theme.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class FavoriteCircuitCard extends StatelessWidget {
  const FavoriteCircuitCard({super.key, required this.circuit});

  final Circuit circuit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.p16),
      child: Container(
        height: Sizes.p120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.trackCardColor,
          borderRadius: BorderRadius.circular(Sizes.p16),
          border: Border.all(color: AppColors.trackCardBorder, width: 2),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              circuit.preview!,
              fit: BoxFit.cover,
              alignment: Alignment.centerRight,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  stops: const [0.0, 0.10, 0.75],
                  colors: [
                    Colors.transparent,
                    AppColors.trackGradientMiddle,
                    AppColors.trackGradientEnd,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.p12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyledText(
                          circuit.description!,
                          fontSize: Sizes.p10,
                          color: AppColors.textMuted,
                          maxLines: 1,
                        ),
                        gapH4,
                        StyledText(
                          circuit.name!,
                          fontSize: Sizes.p12,
                          maxLines: 1,
                        ),
                        gapH4,
                        StyledText(
                          circuit.lengthKm!,
                          fontSize: Sizes.p10,
                          color: AppColors.textMuted,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  gapW8,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Symbols.laps,
                        color: AppColors.primaryAccent,
                        size: Sizes.p20,
                      ),
                      gapW4,
                      StyledText("Circuit fav.", fontSize: Sizes.p10),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
