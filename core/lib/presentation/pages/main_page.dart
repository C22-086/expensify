import 'package:core/core.dart';
import 'package:core/presentation/pages/overview_page.dart';
import 'package:core/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_nav_item.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return const HomePage();
        case 1:
          return const OverviewPage();
        case 2:
          return const SettingsPage();
        default:
          return const HomePage();
      }
    }

    Widget buttonNavigasi() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 60,
          width: double.infinity,
          margin: const EdgeInsets.only(
            bottom: 15,
            left: defaultMargin,
            right: defaultMargin,
          ),
          padding: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: kWhite),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              CustomBottomNavigation(
                index: 0,
                iconPath: 'assets/icon_home.png',
              ),
              CustomBottomNavigation(
                index: 1,
                iconPath: 'assets/icon_chart.png',
              ),
              CustomBottomNavigation(
                index: 2,
                iconPath: 'assets/icon_setting.png',
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<SetPage, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: Stack(
            children: [
              buildContent(currentIndex),
              buttonNavigasi(),
            ],
          ),
        );
      },
    );
  }
}
