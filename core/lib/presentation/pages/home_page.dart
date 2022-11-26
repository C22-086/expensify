import 'package:core/core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/green_substract.png'),
                fit: BoxFit.cover,
              ),
              color: Color(0xff1F8B4E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 30,
              left: 30,
              top: 55,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/icon_wallet.png'),
                            const SizedBox(width: 9),
                            Text(
                              'Balance',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                color: kWhite,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text('IDR 5.000.000',
                            style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: kWhite)),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: kWhite,
                      child: CircleAvatar(
                        radius: 25,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 146,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      buildOverviewChart(),
                      buildOverviewChart(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Container buildOverviewChart() {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: kWhite,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Income Overview'),
                  const SizedBox(width: 10),
                  Image.asset('assets/icon-trending-up.png'),
                ],
              ),
              Text(
                '+ IDR 400K',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: kGreen,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '30% from transfer',
                style: GoogleFonts.poppins(
                  color: const Color(0xff6C6C6C),
                ),
              ),
              Text(
                '70& from salary',
                style: GoogleFonts.poppins(
                  color: const Color(0xff6C6C6C),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 84,
            width: 84,
            child: PieChart(
              PieChartData(
                  pieTouchData: PieTouchData(enabled: true),
                  centerSpaceColor: Colors.transparent,
                  centerSpaceRadius: 30,
                  sections: [
                    PieChartSectionData(
                      color: const Color(0xff1F8B4E),
                      value: 70,
                      title: '70%',
                      radius: 20,
                    ),
                    PieChartSectionData(
                      color: const Color(0xffE6F7E6),
                      value: 30,
                      title: '30%',
                      radius: 20,
                    ),
                  ]),
              swapAnimationCurve: Curves.linear,
              swapAnimationDuration: const Duration(
                milliseconds: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
