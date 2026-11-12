import 'package:flutter/material.dart';
import 'package:keeptrack/src/common_widget/flag_avatar.dart';
import 'package:keeptrack/src/common_widget/info_line.dart';
import 'package:keeptrack/src/common_widget/section_title.dart';
import 'package:keeptrack/src/common_widget/styled_card.dart';
import 'package:keeptrack/src/common_widget/styled_text.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/src/features/user/domain/user.dart';
import 'package:keeptrack/src/features/user/presentation/user_home/last_result_widget/lap_times_chart.dart';
import 'package:keeptrack/theme/theme.dart';

class LastResult extends StatelessWidget {
  const LastResult(this.currentUser, {super.key});

  final User currentUser;

  @override
  Widget build(BuildContext context) {
    final lastPerformance = currentUser.performances.last;
    final lastVoiturePerformance = lastPerformance.voitures.last;

    return StyledCard(
      padding: EdgeInsets.symmetric(vertical: Sizes.p16, horizontal: Sizes.p12),
      color: AppColors.cardColor,
      borderColor: AppColors.cardBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle("Dernier Resultat :"),
          gapH12,
          Container(
            decoration: BoxDecoration(
              color: AppColors.cardBorder,
              borderRadius: BorderRadius.circular(Sizes.p12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p8),
              child: Row(
                children: [
                  FlagAvatar(lastPerformance.circuit.location),
                  gapW12,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StyledText(
                        lastPerformance.circuit.name!,
                        fontSize: Sizes.p16,
                      ),
                      StyledText(
                        lastPerformance.circuit.country!,
                        fontSize: Sizes.p12,
                        color: AppColors.textMuted,
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox(width: 0)),
                  Image.asset(
                    lastPerformance.circuit.outline!,
                    width: Sizes.p96,
                  ),
                ],
              ),
            ),
          ),
          gapH16,
          Row(
            children: [
              StyledText("Temps au tour", color: AppColors.textMuted),
              Expanded(child: gapW4),
              StyledCard(
                color: AppColors.cardBorder,
                borderColor: AppColors.tabBarBorder,
                child: StyledText("7 tours", fontSize: Sizes.p12),
              ),
            ],
          ),
          gapH16,
          LapTimesChart(),
          gapH16,
          InfoLine(
            label: "Voiture",
            value: "${lastVoiturePerformance.voiture.name}",
          ),
          InfoLine(
            label: "Meilleur temps",
            value: lastVoiturePerformance.meilleurTemps,
            valueColor: AppColors.textBestLap,
          ),
          InfoLine(
            label: "Moyenne",
            value: lastVoiturePerformance.formaterTemps(
              lastVoiturePerformance.moyenneEnMs,
            ),
          ),
        ],
      ),
    );
  }
}
