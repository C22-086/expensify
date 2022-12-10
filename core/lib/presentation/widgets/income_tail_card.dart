import 'package:flutter/material.dart';

import '../../core.dart';

class IncomeTailCard extends StatelessWidget {
  const IncomeTailCard({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.amount,
    required this.category,
    required this.date,
    required this.label,
    required this.color,
    required this.currencyColor,
  }) : super(key: key);
  final String title;
  final String iconPath;
  final Color color;
  final Color currencyColor;
  final String label;
  final String amount;
  final String category;
  final String date;

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
              Text(title, style: kHeading7),
              const SizedBox(height: 5),
              Text(
                category,
                style: kBodyText,
              ),
              const SizedBox(height: 5),
              Text(date, style: kBodyText),
            ],
          ),
          const Spacer(),
          Text(
            "$label $amount",
            style: kHeading6.copyWith(
              color: currencyColor,
            ),
          )
        ],
      ),
    );
  }
}
