import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeptrack/src/common_widget/app_background.dart';
import 'package:keeptrack/src/common_widget/my_app_bar.dart';
import 'package:keeptrack/src/common_widget/section_title.dart';
import 'package:keeptrack/src/common_widget/styled_card.dart';
import 'package:keeptrack/src/common_widget/tab_item.dart';
import 'package:keeptrack/src/constants/app_sizes.dart';
import 'package:keeptrack/src/features/circuit/domain/circuit.dart';
import 'package:keeptrack/src/features/circuit/presentation/list_circuits/list_circuits_screen.dart';
import 'package:keeptrack/src/features/user/data/remote/nodejs_users_repository.dart';
import 'package:keeptrack/src/features/user/domain/user.dart';
import 'package:keeptrack/src/features/user/presentation/profile/profile_screen.dart';
import 'package:keeptrack/src/features/user/presentation/user_home/last_result_widget/last_result.dart';
import 'package:keeptrack/src/features/user/presentation/user_home/last_track_driven.dart';
import 'package:keeptrack/src/features/user/presentation/user_home/objectifs_widget/objectifs_carousel.dart';
import 'package:keeptrack/theme/theme.dart';

class UserHomeScreen extends ConsumerWidget {
  const UserHomeScreen({super.key, this.user, this.circuit});

  final User? user;
  final Circuit? circuit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersListValue = ref.watch(usersListFutureProvider);
    final size = MediaQuery.sizeOf(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: AppBackground(
          child: Padding(
            padding: EdgeInsets.only(
              left: Sizes.p16,
              right: Sizes.p16,
              top: Sizes.p32,
              bottom: Sizes.p12
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyAppBar(),
                gapH12,
                Container(
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(Sizes.p100)),
                    border: BoxBorder.all(
                      color: AppColors.cardBorder,
                      width: 2,
                    ),
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.p100),
                      ),
                    ),
                    tabs: [
                      TabItem(title: 'Home'),
                      TabItem(title: 'Circuits'),
                      TabItem(title: 'Profile'),
                    ],
                  ),
                ),
                gapH16,
                Expanded(
                  child: usersListValue.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) =>
                        Center(child: Center(child: Text(error.toString()))),
                    data: (users) {
                      if (users.isEmpty) {
                        return const Center(
                          child: Text('Aucun utilisateur trouvé'),
                        );
                      }

                      final currentUser = users.first;

                      return TabBarView(
                        children: [
                          HomeScreen(currentUser),
                          ListCircuitsScreen(),
                          ProfileScreen(currentUser),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen(this.user, {super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SectionTitle("Objectifs en cours :"),
        gapH12,
        ObjectifsCarousel(user.objectifs, user.performances),
        gapH24,
        LastResult(user),
        gapH8,
        StyledCard(
          child: Column(
            children: [
              SectionTitle("Derniers Circuits roules :"),
              ...user.performances.reversed.map(
                (performance) => LastTrackDriven(performance.circuit),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
