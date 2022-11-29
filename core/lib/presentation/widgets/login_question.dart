import 'package:core/core.dart';
import 'package:flutter/material.dart';

class LogInQuestion extends StatelessWidget {
  final Function() onPressed;

  const LogInQuestion({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Belum memiliki akun?',
          style: kSubtitle,
        ),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: onPressed,
          child: Text(
            'Daftar',
            style: kSubtitle.copyWith(
              color: kGreen,
            ),
          ),
        )
      ],
    );
  }
}
