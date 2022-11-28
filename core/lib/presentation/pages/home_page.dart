import 'package:core/core.dart';
import 'package:core/presentation/widgets/custom_header_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_add_card.dart';
import '../widgets/custome_overview_card.dart';
import '../widgets/income_tail_card.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    buildHeader() {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultMargin, vertical: 25),
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
                  Text(
                    'IDR 5.000.000',
                    style: kHeading6.copyWith(color: kWhite, fontSize: 22),
                  ),
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
      );
    }

    buildCard() {
      return ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(height: height * 0.025),
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
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailIncomePage.routeName,
                    );
                  },
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
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailExpensePage.routeName,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      );
    }

    buildMainFuture() {
      return Padding(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: height * 0.04,
        ),
        child: Row(
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
              ),
            ),
          ],
        ),
      );
    }

    buildContent() {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                return const IncomeTailCard(
                  iconPath: 'assets/icon_up.png',
                  color: kSoftGreen,
                );
              },
            )
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
            const BackgroundHeader(height: 0.32),
            Column(
              children: [
                buildHeader(),
                buildCard(),
                buildMainFuture(),
                Expanded(
                  child: SizedBox(
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        buildContent(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
