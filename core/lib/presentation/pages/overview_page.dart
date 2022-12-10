import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/domain/entities/chart_income.dart';
import 'package:core/utils/format_currency.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  bool isActive = false;

  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  Future fetchUserData() async {
    final userRef = FirebaseDatabase.instance.ref('users/$currentUserId');
    final json = await userRef.get();
    final data = jsonDecode(jsonEncode(json.value));
    return data;
  }

  @override
  void initState() {
    super.initState();
  }

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
      return FutureBuilder(
        future: fetchUserData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final Map<String, dynamic> user =
              snapshot.data as Map<String, dynamic>;
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
                      style: kHeading7.copyWith(
                          color: Colors.black45, fontSize: 18),
                    ),
                    Text(
                      formatCurrency.format(user['balance']),
                      style: kHeading7.copyWith(
                        color: kGreen,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
        },
      );
    }

    buildChart(List data) {
      final List income = data.where((e) => e['type'] == 'income').toList();

      final List expanses = data.where((e) => e['type'] == 'expanse').toList();

      return Padding(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(
          children: [
            const Divider(),
            SizedBox(
              width: double.maxFinite,
              child: SfCartesianChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                title: ChartTitle(text: 'Diagram Semua Transaksi'),
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
                  ColumnSeries<ChartIncome, String>(
                    dataLabelMapper: (datum, index) {
                      return formatCurrency.format(datum.amount.toInt());
                    },
                    dataSource:
                        income.map((e) => ChartIncome.fromMap(e)).toList(),
                    xValueMapper: (ChartIncome data, _) => data.category,
                    yValueMapper: (ChartIncome data, _) => data.amount,
                    // dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                  ColumnSeries<ChartIncome, String>(
                    dataLabelMapper: (datum, index) {
                      return formatCurrency.format(datum.amount.toInt());
                    },
                    dataSource:
                        expanses.map((e) => ChartIncome.fromMap(e)).toList(),
                    xValueMapper: (ChartIncome data, _) => data.category,
                    yValueMapper: (ChartIncome data, _) => data.amount,
                  ),
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              width: double.maxFinite,
              child: SfCartesianChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                title: ChartTitle(text: 'Diagram Pemasukkan'),
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
                  ColumnSeries<ChartIncome, String>(
                    dataLabelMapper: (datum, index) {
                      return formatCurrency.format(datum.amount.toInt());
                    },
                    dataSource:
                        income.map((e) => ChartIncome.fromMap(e)).toList(),
                    xValueMapper: (ChartIncome data, _) => data.category,
                    yValueMapper: (ChartIncome data, _) => data.amount,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              width: double.maxFinite,
              child: SfCartesianChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                title: ChartTitle(text: 'Diagram Pengeluaran'),
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
                  ColumnSeries<ChartIncome, String>(
                    dataLabelMapper: (datum, index) {
                      return formatCurrency.format(datum.amount.toInt());
                    },
                    dataSource:
                        expanses.map((e) => ChartIncome.fromMap(e)).toList(),
                    xValueMapper: (ChartIncome data, _) => data.category,
                    yValueMapper: (ChartIncome data, _) => data.amount,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    buildCategory(data) {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Income vs Expanse",
              style: kHeading6,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CategoryItem(data: data),
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
          // buildButton(),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseDatabase.instance
                    .ref('transaction/$currentUserId')
                    .onValue,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      final data = snapshot.data.snapshot.value;
                      final listData = data.values.toList();

                      return ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          buildBalanceInformation(),
                          buildCategory(listData),
                          buildChart(listData),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text('No Data'),
                      );
                    }
                  }
                }),
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
    required this.data,
  }) : super(key: key);

  final List data;

  @override
  Widget build(BuildContext context) {
    final dataIncome =
        data.where((element) => element['type'] == 'income').toList();
    final dataExpanse =
        data.where((element) => element['type'] == 'expanse').toList();
    final totalPercent = dataIncome.length / data.length;

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Incomes',
                style: GoogleFonts.poppins(fontSize: 18),
              ),
              Text(
                'Expanses',
                style: GoogleFonts.poppins(fontSize: 18),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          LinearPercentIndicator(
            animation: true,
            backgroundColor: Colors.orange,
            progressColor: kGreen,
            center: Text(
              "${(totalPercent * 100).toStringAsFixed(1)} %",
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
            percent: totalPercent,
            lineHeight: 20,
            barRadius: const Radius.circular(20),
          ),
          SfCircularChart(
            title: ChartTitle(text: 'Pemasukkan'),
            tooltipBehavior: TooltipBehavior(enable: true),
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              position: LegendPosition.bottom,
            ),
            series: [
              PieSeries<ChartIncome, String>(
                enableTooltip: true,
                dataLabelMapper: (datum, index) {
                  return formatCurrency.format((datum.amount).toInt());
                },
                dataSource: dataIncome
                    .map((e) =>
                        ChartIncome(e['category'], e['amount'].toDouble()))
                    .toList(),
                xValueMapper: (ChartIncome data, _) => data.category,
                yValueMapper: (ChartIncome data, _) => data.amount,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                ),
              ),
            ],
          ),
          SfCircularChart(
            title: ChartTitle(text: 'Pengeluaran'),
            tooltipBehavior: TooltipBehavior(enable: true),
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              position: LegendPosition.bottom,
            ),
            series: [
              PieSeries<ChartIncome, String>(
                enableTooltip: true,
                dataLabelMapper: (datum, index) {
                  return formatCurrency.format((datum.amount).toInt());
                },
                dataSource: dataExpanse
                    .map((e) =>
                        ChartIncome(e['category'], e['amount'].toDouble()))
                    .toList(),
                xValueMapper: (ChartIncome data, _) => data.category,
                yValueMapper: (ChartIncome data, _) => data.amount,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
