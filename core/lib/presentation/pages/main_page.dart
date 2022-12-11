import 'package:core/core.dart';
import 'package:core/presentation/pages/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main';
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime currentBackPressTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetPage, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0.1,
            selectedLabelStyle: kSubtitle.copyWith(fontSize: 12),
            selectedItemColor: kGreen,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (value) => context.read<SetPage>().setPage(value),
            items: [
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  'assets/icon_home.png',
                  color: kGreen,
                  width: 20,
                ),
                icon: Image.asset(
                  'assets/icon_home.png',
                  color: Colors.grey,
                  width: 20,
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  'assets/icon_chart.png',
                  width: 20,
                  color: Colors.green,
                ),
                icon: Image.asset('assets/icon_chart.png', width: 20),
                label: 'Grafik',
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
                label: 'Pengaturan',
              ),
            ],
          ),
          body: WillPopScope(
            onWillPop: () async {
              final difference =
                  DateTime.now().difference(currentBackPressTime);
              final exitWarning = difference >= const Duration(seconds: 2);
              currentBackPressTime = DateTime.now();
              if (exitWarning) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tekan sekali lagi untuk keluar'),
                  ),
                );
                return false;
              } else {
                return true;
              }
            },
            child: IndexedStack(
              index: currentIndex,
              children: const [
                HomePage(),
                OverviewPage(),
                SettingsPage(),
              ],
            ),
          ),
        );
      },
    );
  }
}
