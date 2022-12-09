import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    super.key,
    required this.title,
    required this.color,
    required this.label,
    required this.secColor,
    required this.onTap,
    required this.titleImageUrl,
    required this.chart,
    required this.total,
  });

  final Color color;
  final Color secColor;
  final String title;
  final String label;
  final String titleImageUrl;
  final Widget chart;
  final String total;

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
                        'Rp. + $total',
                        style: kHeading7.copyWith(
                          fontSize: 20,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'ss',
                        style: kBodyText.copyWith(
                          color: state ? kWhite : Colors.grey,
                        ),
                      ),
                      Text(
                        'subMaxPercent',
                        style: kBodyText.copyWith(
                          color: state ? kWhite : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: SizedBox(child: chart),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
