import 'package:flutter/material.dart';
import 'package:keeptrack/src/common_widget/styled_text.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/src/features/user/domain/user.dart';
import 'package:keeptrack/src/features/voiture/domain/voiture.dart';
import 'package:keeptrack/theme/theme.dart';

class FavoriteCarCard extends StatelessWidget {
  const FavoriteCarCard({super.key, required this.voiture, required this.user});

  final Voiture voiture;
  final User user;

  @override
  Widget build(BuildContext context) {
    final totalTours = user.nbreToursVoiture(voiture);

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
              voiture.overview!,
              fit: BoxFit.cover,
              alignment: Alignment.centerLeft,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.directions_car,
                        color: AppColors.primaryAccent,
                        size: Sizes.p20,
                      ),
                      gapW4,
                      StyledText("Voiture fav.", fontSize: Sizes.p10),
                    ],
                  ),
                  gapW8,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        StyledText(
                          voiture.brand!,
                          fontSize: Sizes.p10,
                          color: AppColors.textMuted,
                          maxLines: 1,
                        ),
                        gapH4,
                        StyledText(
                          voiture.name!,
                          fontSize: Sizes.p12,
                          maxLines: 1,
                        ),
                        gapH4,
                        StyledText(
                          "$totalTours tours",
                          fontSize: Sizes.p10,
                          color: AppColors.textMuted,
                          maxLines: 1,
                        ),
                      ],
                    ),
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
