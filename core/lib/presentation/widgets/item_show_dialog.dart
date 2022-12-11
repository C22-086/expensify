import 'package:flutter/material.dart';

import '../../core.dart';

class DetailItemDialog extends StatelessWidget {
  const DetailItemDialog({
    Key? key,
    required this.subtitle,
    required this.title,
    required this.icon,
    required this.color,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Widget icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: icon),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: kHeading6.copyWith(fontSize: 16),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            subtitle,
            style: kHeading6.copyWith(fontSize: 16),
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }
}
