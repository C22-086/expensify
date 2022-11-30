import 'package:core/core.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings_page';

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    buildAppBar() => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: defaultMargin,
            ),
            child: Center(
              child: Text(
                "Settings",
                style: kHeading6.copyWith(color: kRichBlack),
              ),
            ),
          ),
        );
    buildHeader() {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 36,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(20, 17, 20, 17),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Edit Profil',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: kWhite,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              Text(
                'Anne Fox',
                style: kHeading6.copyWith(color: kSoftBlack),
              ),
              const SizedBox(
                height: 6,
              ),
              Text('annefox@gmail.com', style: kSubtitle),
            ],
          ),
        ),
      );
    }

    buildList() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: kGrey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Image.asset(
                  'assets/icon_darkmode.png',
                ),
              ),
              title: Text(
                'Dark Mode',
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kSoftBlack),
              ),
              trailing: SizedBox(
                width: 100,
                child: FlutterSwitch(
                  width: 105.0,
                  height: 40.0,
                  valueFontSize: 18.0,
                  toggleSize: 35.0,
                  value: status,
                  borderRadius: 30.0,
                  padding: 8.0,
                  showOnOff: true,
                  activeIcon: const Icon(Icons.sunny),
                  inactiveColor: kGrey,
                  activeColor: kGreen,
                  onToggle: (val) {
                    setState(() {
                      status = val;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 33,
            ),
            ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kGrey,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Image.asset(
                    'assets/icon_export.png',
                  ),
                ),
                title: Text(
                  'Export Data',
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kSoftBlack),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                )),
            const SizedBox(
              height: 33,
            ),
            ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kGrey,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Image.asset(
                    'assets/logout.png',
                  ),
                ),
                title: Text(
                  'Log Out',
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kSoftBlack),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                ))
          ],
        ),
      );
    }

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
            );
          }
        },
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAppBar(),
                Expanded(
                    child: SizedBox(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [buildHeader(), buildList()],
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
