import 'package:flutter/material.dart';
import 'package:keeptrack/src/common_widget/styled_card.dart';
import 'package:keeptrack/src/common_widget/styled_text.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/src/features/user/domain/voiture_performance.dart';

class CarResultCard extends StatelessWidget {
  const CarResultCard(this.voiturePerformance, {super.key});

  final VoiturePerformance voiturePerformance;

  @override
  Widget build(BuildContext context) {
    return StyledCard(
      child: Row(
        children: [
          Container(
            width: Sizes.p96,
            height: Sizes.p72,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(voiturePerformance.voiture.preview!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(Sizes.p12)),
            ),
          ),
          gapW12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledText(
                  voiturePerformance.voiture.name!,
                  fontSize: Sizes.p12,
                  maxLines: 1,
                ),
                gapH8,
                StyledText(
                  "${voiturePerformance.temps.length} Tours",
                  fontSize: Sizes.p12,
                ),
                gapH8,
                StyledText(
                  "Meilleur tour : ${voiturePerformance.meilleurTemps}",
                  fontSize: Sizes.p12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
