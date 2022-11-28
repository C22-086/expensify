import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({super.key, required this.heading, required this.subHeading});

  final String heading;
  final String subHeading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Text(
          'Expensify',
          style: kTitle,
        ),
        const SizedBox(height: 28),
        Text(
          heading,
          style: kHeading5,
        ),
        const SizedBox(height: 5),
        Text(
          subHeading,
          style: kBodyText,
        ),
        const SizedBox(height: 26),
      ],
    );
  }
}
