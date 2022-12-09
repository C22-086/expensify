import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/presentation/widgets/income_tail_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../widgets/back_button.dart';
import '../widgets/custom_category.dart';
import '../widgets/custom_header_app.dart';

class DetailExpensePage extends StatefulWidget {
  static const routeName = '/detail_expense_page';
  const DetailExpensePage({super.key});

  @override
  State<DetailExpensePage> createState() => _DetailExpensePageState();
}

class _DetailExpensePageState extends State<DetailExpensePage> {
  Future fetchUserTransaction() async {
    var transactions = [];
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final transactionRef =
          FirebaseDatabase.instance.ref('transaction/$currentUserId');
      final json = await transactionRef.orderByKey().get();
      final data = jsonDecode(jsonEncode(json.value)) as Map;
      data.forEach((key, value) {
        transactions.add(value);
      });
      print(transactions);
      return transactions;
    } catch (e) {
      return ServerFailure;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    buildAppBar() => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  "Expenses overview",
                  style: kHeading6.copyWith(color: kWhite),
                ),
                const SizedBox(width: 20)
              ],
            ),
          ),
        );

    buildCategory() => Padding(
          padding: EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin,
            top: height * 0.03,
            bottom: height * 0.01,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CustomeCategory(
                index: 0,
                title: "Last Year",
                titleColor: kRed,
              ),
              CustomeCategory(
                index: 1,
                title: "Last Month",
                titleColor: kRed,
              ),
              CustomeCategory(
                index: 2,
                title: "Last Week",
                titleColor: kRed,
              ),
              CustomeCategory(
                index: 3,
                title: "Last Day",
                titleColor: kRed,
              ),
            ],
          ),
        );

    buildCardIncome() => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Container(
            height: 180,
            padding: const EdgeInsets.only(
              left: 20,
              top: 20,
              bottom: 20,
              right: 50,
            ),
            decoration: BoxDecoration(
              color: kDarkRed,
              borderRadius: BorderRadius.circular(14),
              image: const DecorationImage(
                image: AssetImage('assets/expense_card.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      '- IDR 900K',
                      style: kHeading5.copyWith(
                        fontSize: 30,
                        color: kWhite,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "30% from tranfer",
                      style: kSubtitle.copyWith(color: kWhite),
                    ),
                    Text(
                      "70% from salary",
                      style: kSubtitle.copyWith(color: kWhite),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 85,
                  width: 85,
                  child: PieChart(
                    PieChartData(
                        pieTouchData: PieTouchData(enabled: true),
                        centerSpaceColor: Colors.transparent,
                        centerSpaceRadius: 40,
                        sections: [
                          PieChartSectionData(
                            color: const Color(0xffFF396F),
                            value: 60,
                            title: "60%",
                            radius: 30,
                            titleStyle: kBodyText.copyWith(color: kWhite),
                          ),
                          PieChartSectionData(
                            color: kWhite,
                            value: 40,
                            title: "40%",
                            radius: 30,
                            titleStyle: kBodyText.copyWith(color: kGreen),
                          ),
                        ]),
                    swapAnimationCurve: Curves.linear,
                    swapAnimationDuration: const Duration(milliseconds: 150),
                  ),
                ),
              ],
            ),
          ),
        );

    buildListIncome() => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin + 5,
            vertical: height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Today", style: kHeading5),
              const SizedBox(height: 15),
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const IncomeTailCard(
                    iconPath: 'assets/icon_up.png',
                    color: kSoftGreen,
                    category: '',
                    nominal: 1,
                    date: '',
                    label: '+',
                    currencyColor: kSoftGreen,
                  );
                },
              ),
              Text("Monday", style: kHeading5),
              const SizedBox(height: 15),
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return const IncomeTailCard(
                    iconPath: 'assets/icon_up.png',
                    color: kSoftGreen,
                    category: '',
                    nominal: 1,
                    date: '',
                    label: '+',
                    currencyColor: kSoftGreen,
                  );
                },
              )
            ],
          ),
        );

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundHeader(
            height: 0.15,
            imagePath: 'assets/red_substract.png',
            color: kDarkRed,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAppBar(),
              buildCategory(),
              Expanded(
                child: SizedBox(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      buildCardIncome(),
                      buildListIncome(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
