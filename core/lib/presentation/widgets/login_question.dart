import 'package:core/core.dart';
import 'package:flutter/material.dart';

class LogInQuestion extends StatelessWidget {
  final Function() onPressed;

  const LogInQuestion(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.buttonText});
  final String text;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: kSubtitle,
        ),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: onPressed,
          child: Text(
            buttonText,
            style: kSubtitle.copyWith(
              color: kGreen,
            ),
          ),
        )
      ],
    );
  }
}
