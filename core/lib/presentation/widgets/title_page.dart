import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({super.key, required this.subHeading});

  final String subHeading;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(height: height * 0.04),
        Text(
          'Expensify',
          style: kTitle,
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
