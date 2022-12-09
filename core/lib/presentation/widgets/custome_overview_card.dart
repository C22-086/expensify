import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    super.key,
    required this.title,
    required this.subMinPercent,
    required this.subMaxPercent,
    required this.chartOneTitle,
    required this.chartTwoTitle,
    required this.valueChartOne,
    required this.valueChartTwo,
    required this.amount,
    required this.color,
    required this.label,
    required this.secColor,
    required this.onTap,
    required this.titleImageUrl,
  });

  final Color color;
  final Color secColor;
  final String title;
  final String label;
  final String subMinPercent;
  final String subMaxPercent;
  final String chartOneTitle;
  final String chartTwoTitle;
  final double valueChartOne;
  final double valueChartTwo;
  final String titleImageUrl;
  final int amount;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: BlocBuilder<ThemeBloc, bool>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: state ? kDark : kWhite,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '$title Overview',
                            style: kBodyText.copyWith(
                              fontSize: 14,
                              color: state ? kWhite : kRichBlack,
                            ),
                          ),
                          Image.asset(
                            titleImageUrl,
                            width: 15,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        ' IDR ${amount}K',
                        style: kHeading7.copyWith(
                          fontSize: 20,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        subMinPercent,
                        style: kBodyText.copyWith(
                          color: state ? kWhite : Colors.grey,
                        ),
                      ),
                      Text(
                        subMaxPercent,
                        style: kBodyText.copyWith(
                          color: state ? kWhite : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 75,
                    width: 75,
                    child: PieChart(
                      PieChartData(
                          pieTouchData: PieTouchData(enabled: true),
                          centerSpaceColor: Colors.transparent,
                          centerSpaceRadius: 30,
                          sections: [
                            PieChartSectionData(
                                color: color,
                                value: valueChartOne,
                                title: chartOneTitle,
                                radius: 20,
                                titleStyle: kBodyText.copyWith(color: kWhite)),
                            PieChartSectionData(
                                color: secColor,
                                value: valueChartTwo,
                                title: chartTwoTitle,
                                radius: 20,
                                titleStyle:
                                    kBodyText.copyWith(color: kRichBlack)),
                          ]),
                      swapAnimationCurve: Curves.linear,
                      swapAnimationDuration: const Duration(milliseconds: 150),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
