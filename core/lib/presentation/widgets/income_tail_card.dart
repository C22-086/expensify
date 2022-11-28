import 'package:flutter/material.dart';

import '../../core.dart';

class IncomeTailCard extends StatelessWidget {
  const IncomeTailCard({
    Key? key,
  }) : super(key: key);

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
  }
}
