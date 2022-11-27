import 'package:core/core.dart';
import 'package:core/presentation/widgets/custome_overview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_add_card.dart';

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
            height: MediaQuery.of(context).size.height * 0.29,
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
            padding: const EdgeInsets.only(top: 25),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/icon_wallet.png',
                                scale: 2.5,
                                color: kWhite,
                              ),
                              const SizedBox(width: 9),
                              Text(
                                'Balance',
                                style: kHeading7.copyWith(color: kWhite),
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
                ),
                const SizedBox(height: 45),
                SizedBox(
                  height: 146,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      OverviewCard(
                        color: kGreen,
                        secColor: kSoftGreen,
                        title: 'Income',
                        label: "+",
                        amount: 400,
                        subMinPercent: "30% from tranfer",
                        subMaxPercent: "70% from salary",
                        valueChartOne: 70,
                        valueChartTwo: 30,
                        chartOneTitle: "70%",
                        chartTwoTitle: "30%",
                        onTap: () {},
                      ),
                      OverviewCard(
                        color: kRed,
                        secColor: kSoftRed,
                        title: 'Expense',
                        label: "-",
                        amount: 700,
                        subMinPercent: "30% from tranfer",
                        subMaxPercent: "70% from salary",
                        valueChartOne: 65,
                        valueChartTwo: 35,
                        chartOneTitle: "65%",
                        chartTwoTitle: "35%",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Expanded(
                              child: AddCard(
                            iconPath: 'assets/icon_income.png',
                            subtitle: 'Income',
                            textColor: kGreen,
                          )),
                          SizedBox(width: 20),
                          Expanded(
                              child: AddCard(
                            iconPath: 'assets/icon_expense.png',
                            subtitle: 'Expense',
                            textColor: kRed,
                          )),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Recent Transaction",
                        style: kHeading5.copyWith(color: kSoftBlack),
                      ),
                      const SizedBox(height: 25),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 8,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    color: kSoftGreen,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.asset(
                                    'assets/icon_up.png',
                                    scale: 2,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Salary", style: kHeading7),
                                    const SizedBox(height: 5),
                                    Text("Nov, 18 2022", style: kBodyText),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  "+ IDR 20.000",
                                  style: kHeading6.copyWith(
                                    color: kGreen,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
