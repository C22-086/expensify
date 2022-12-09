import 'package:core/core.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    buildHeader() {
      return Container(
        height: 110,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: kGreen,
          image: DecorationImage(
            image: AssetImage('assets/income_card.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Text(
              "Statistic",
              style: kHeading6.copyWith(
                color: kWhite,
                fontSize: 22,
              ),
            ),
          ),
        ),
      );
    }

    buildButton() {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Container(
          height: 75,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: context.watch<ThemeBloc>().state ? kSoftBlack : kSoftGrey,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  decoration: BoxDecoration(
                    color: isActive == true
                        ? Colors.transparent
                        : context.watch<ThemeBloc>().state
                            ? kDark
                            : kWhite,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    child: Text(
                      "Income",
                      style: kHeading6.copyWith(
                        color: isActive == true ? kGrey : kGreen,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    isActive = false;
                  });
                },
              ),
              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  decoration: BoxDecoration(
                    color: isActive == true
                        ? context.watch<ThemeBloc>().state
                            ? kDark
                            : kWhite
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    child: Text(
                      "Expense",
                      style: kHeading6.copyWith(
                        color: isActive == true ? kRed : kGrey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    isActive = true;
                  });
                },
              ),
            ],
          ),
        ),
      );
    }

    buildBalanceInformation() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Balance",
                  style: kHeading7,
                ),
                Text(
                  "IDR 400.000",
                  style: kHeading7.copyWith(
                      color: kGreen, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 60,
              width: 120,
              child: DropdownSearch(
                items: const [
                  "Day",
                  "Week",
                  "Month",
                  "Year",
                ],
                onChanged: print,
                selectedItem: "Day",
              ),
            ),
          ],
        ),
      );
    }

    buildChart() {
      return Padding(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: SizedBox(
          height: 240,
          width: double.maxFinite,
          child: PieChart(
            PieChartData(
                pieTouchData: PieTouchData(enabled: true),
                centerSpaceColor: Colors.transparent,
                centerSpaceRadius: 65,
                sections: [
                  PieChartSectionData(
                      color: kRichBlack,
                      value: 10,
                      title: "10",
                      radius: defaultChartRadius,
                      titleStyle: kBodyText.copyWith(color: kWhite)),
                  PieChartSectionData(
                      color: kGreen,
                      value: 40,
                      title: "10",
                      radius: defaultChartRadius,
                      titleStyle: kBodyText.copyWith(color: kRichBlack)),
                  PieChartSectionData(
                      color: kPrussianBlue,
                      value: 15,
                      title: "10",
                      radius: defaultChartRadius,
                      titleStyle: kBodyText.copyWith(color: kWhite)),
                  PieChartSectionData(
                      color: kSoftGreen,
                      value: 10,
                      title: "10",
                      radius: defaultChartRadius,
                      titleStyle: kBodyText.copyWith(color: kRichBlack)),
                  PieChartSectionData(
                      color: kRed,
                      value: 10,
                      title: "10",
                      radius: defaultChartRadius,
                      titleStyle: kBodyText.copyWith(color: kRichBlack)),
                ]),
            swapAnimationCurve: Curves.linear,
            swapAnimationDuration: const Duration(milliseconds: 150),
          ),
        ),
      );
    }

    buildCategory() {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Categories",
              style: kHeading6,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: const [
                  CategoryItem(),
                  CategoryItem(),
                  CategoryItem(),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildHeader(),
          buildButton(),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                buildBalanceInformation(),
                buildChart(),
                buildCategory(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isItemDisabled(String s) {
    if (s.startsWith('I')) {
      return true;
    } else {
      return false;
    }
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 110,
                  child: Chip(
                    backgroundColor: Colors.transparent,
                    labelStyle: kHeading6,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: kGreen, width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(14),
                      ),
                    ),
                    label: Row(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          decoration: const BoxDecoration(
                            color: kGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text("Food"),
                      ],
                    ),
                  ),
                ),
                Text(
                  "IDR 290.000",
                  style: kHeading7.copyWith(
                      color: kGreen, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          LinearPercentIndicator(
            animation: true,
            barRadius: const Radius.circular(20),
            lineHeight: 20.0,
            animationDuration: 2500,
            percent: 0.8,
            center: Text(
              "80.0%",
              style: kSubtitle.copyWith(color: kWhite),
            ),
            progressColor: kGreen,
          ),
        ],
      ),
    );
  }
}
