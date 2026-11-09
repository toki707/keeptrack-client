import 'package:flutter/material.dart';
import 'package:keeptrack/src/common_widget/styled_card.dart';
import 'package:keeptrack/src/common_widget/styled_text.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/theme/theme.dart';
import 'package:material_symbols_icons/symbols.dart';

class SuccessCard extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StyledCard(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Icon(
              Symbols.trophy,
              color: AppColors.primaryAccent,
              size: Sizes.p32,
            ),
            gapH8,
            StyledText(
              "Succès",
              color: AppColors.textMuted,
              fontSize: Sizes.p16,
            ),
            gapH4,
            StyledText("11/709", fontSize: Sizes.p32),
            gapH12,
            Container(
              height: Sizes.p12,
              decoration: BoxDecoration(
                color: AppColors.progressBackground,
                borderRadius: BorderRadius.circular(Sizes.p8),
              ),
              alignment: .centerLeft,
              child: FractionallySizedBox(
                widthFactor: 11 / 709,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Sizes.p8),
                    gradient: LinearGradient(
                      colors: [AppColors.primaryColor, AppColors.primaryAccent],
                    ),
                  ),
                ),
              ),
            ),
            gapH16,
          ],
        ),
      ),
    );
  }
}
