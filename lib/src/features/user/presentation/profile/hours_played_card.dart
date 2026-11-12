import 'package:flutter/material.dart';
import 'package:keeptrack/src/common_widget/styled_card.dart';
import 'package:keeptrack/src/common_widget/styled_text.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/src/features/user/domain/user.dart';
import 'package:keeptrack/theme/theme.dart';

class HoursPlayedCard extends StatelessWidget {
  const new({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StyledCard(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Icon(
              Icons.timer_outlined,
              color: AppColors.primaryAccent,
              size: Sizes.p24,
            ),
            gapH8,
            StyledText(
              "Heures jouées",
              color: AppColors.textMuted,
              fontSize: Sizes.p12,
            ),
            gapH8,
            StyledText(
              "${user.nbreHeursJouees.toStringAsFixed(1)} h",
              fontSize: Sizes.p20,
            ),
            gapH2,
          ],
        ),
      ),
    );
  }
}
