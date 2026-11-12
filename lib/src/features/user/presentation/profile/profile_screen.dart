import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      padding: EdgeInsets.zero,
      children: [
        Column(
          crossAxisAlignment: .start,
          children: [
            Stack(
              children: [
                Container(
                  height: Sizes.p148,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Sizes.p20)),
                    image: DecorationImage(
                      image: AssetImage(user.banner!),
                      opacity: 0.8,
                      fit: .cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Sizes.p20, top: Sizes.p96),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 53, 0, 0),
                    radius: Sizes.p48,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Sizes.p24, top: Sizes.p100),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(user.pfp!),
                    radius: 44,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 84, top: 152),
                  child: CircleAvatar(
                    backgroundColor: AppColors.textBestLap,
                    radius: Sizes.p20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 86, top: 154),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 53, 0, 0),
                    radius: 18,
                    child: Center(child: StyledText("12", fontSize: Sizes.p16 )),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.p16,
                vertical: Sizes.p4,
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  StyledText(user.name!, fontSize: Sizes.p24),
                  StyledText(
                    "@${user.at!}",
                    color: AppColors.textMuted,
                    fontSize: Sizes.p16,
                  ),
                ],
              ),
            ),
            Divider(color: Colors.white, thickness: 2),
            gapH16,
            Row(
              children: [
                HoursPlayedCard(user: user),
                gapW12,
                SuccessCard(),
              ],
            ),
            gapH16,
          ],
        ),
      ],
    );
  }
}
