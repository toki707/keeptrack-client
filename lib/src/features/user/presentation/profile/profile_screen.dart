import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeptrack/src/common_widget/styled_card.dart';
import 'package:keeptrack/src/common_widget/styled_text.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/src/features/user/domain/user.dart';
import 'package:keeptrack/src/features/user/presentation/profile/hours_played_card.dart';
import 'package:keeptrack/src/features/user/presentation/profile/success_card.dart';
import 'package:keeptrack/theme/theme.dart';

class ProfileScreen extends ConsumerWidget {
  const new(this.user, {super.key});

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: .start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: 1000,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: AssetImage(user.banner!),
                      opacity: 0.8,
                      fit: .fitWidth,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 27, top: 137),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 53, 0, 0),
                    radius: 63,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 140),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(user.pfp!),
                    radius: 60,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 108, top: 208),
                  child: CircleAvatar(
                    backgroundColor: AppColors.textBestLap,
                    radius: 30,
                    child: Center(child: StyledText("12", fontSize: Sizes.p20)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 110, top: 210),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 53, 0, 0),
                    radius: 28,
                    child: Center(child: StyledText("12", fontSize: Sizes.p20)),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.p28,
                vertical: Sizes.p4,
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  StyledText(user.name!, fontSize: Sizes.p32),
                  StyledText(
                    "@${user.at!}",
                    color: AppColors.textMuted,
                    fontSize: Sizes.p28,
                  ),
                ],
              ),
            ),
            Divider(color: Colors.white, thickness: 2),
            gapH20,
            Row(
              children: [
                HoursPlayedCard(user: user),
                gapW16,
                SuccessCard(),
                gapW16,
              ],
            ),
            gapH20,
          ],
        ),
      ],
    );
  }
}
