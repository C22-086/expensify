import 'package:core/core.dart';
import 'package:core/presentation/pages/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  static const routeName = '/main';
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

    // Widget buttonNavigasi() {
    //   return Align(
    //     alignment: Alignment.bottomCenter,
    //     child: Container(
    //       height: 60,
    //       width: double.infinity,
    //       margin: const EdgeInsets.only(
    //         bottom: 15,
    //         left: defaultMargin,
    //         right: defaultMargin,
    //       ),
    //       padding: const EdgeInsets.symmetric(vertical: 2),
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(14), color: kWhite),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: const [
    //           CustomBottomNavigation(
    //             index: 0,
    //             iconPath: 'assets/icon_home.png',
    //           ),
    //           CustomBottomNavigation(
    //             index: 1,
    //             iconPath: 'assets/icon_chart.png',
    //           ),
    //           CustomBottomNavigation(
    //             index: 2,
    //             iconPath: 'assets/icon_setting.png',
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    return BlocBuilder<SetPage, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0.1,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (value) => context.read<SetPage>().setPage(value),
            items: [
              BottomNavigationBarItem(
                activeIcon: Image.asset('assets/icon_home.png',
                    color: Colors.green, width: 20),
                icon: Image.asset(
                  'assets/icon_home.png',
                  color: Colors.grey,
                  width: 20,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  'assets/icon_chart.png',
                  width: 20,
                  color: Colors.green,
                ),
                icon: Image.asset('assets/icon_chart.png', width: 20),
                label: 'Overview',
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  'assets/icon_setting.png',
                  width: 20,
                  color: Colors.green,
                ),
                icon: Image.asset(
                  'assets/icon_setting.png',
                  width: 20,
                ),
                label: 'Settings',
              ),
            ],
          ),
          body: Stack(
            children: [
              buildContent(currentIndex),
              // buttonNavigasi(),
            ],
          ),
        );
      },
    );
  }
}
