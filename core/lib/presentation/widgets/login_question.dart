import 'package:core/core.dart';
import 'package:flutter/material.dart';

class LogInQuestion extends StatelessWidget {
  const LogInQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Belum memiliki akun?',
          style: kBodyText,
        ),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RegisterPage.routeName);
          },
          child: const Text(
            'Daftar',
            style: TextStyle(
              color: kGreen,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        )
      ],
    );
  }
}
