import 'package:flutter/material.dart';

import '../../core.dart';

class IncomeTailCard extends StatelessWidget {
  const IncomeTailCard({
    Key? key,
    required this.iconPath,
    this.color = kSoftGreen,
    this.currencyColor = kGreen,
    this.label = '+',
  }) : super(key: key);

  final String iconPath;
  final Color color;
  final Color currencyColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              iconPath,
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
            "$label IDR 20.000",
            style: kHeading6.copyWith(
              color: currencyColor,
            ),
          )
        ],
      ),
    );
  }
}
