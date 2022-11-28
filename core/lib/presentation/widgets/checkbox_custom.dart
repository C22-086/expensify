import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CheckBoxLogIn extends StatelessWidget {
  const CheckBoxLogIn(
      {super.key, required this.isAgree, required this.onChanged});

  final bool? isAgree;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: isAgree,
              onChanged: onChanged,
            ),
            Text(
              'Ingat saya',
              style: kBodyText,
            ),
          ],
        ),
        Text(
          'Lupa kata sandi?',
          style: kBodyText,
        )
      ],
    );
  }
}

class CheckBoxRegister extends StatelessWidget {
  const CheckBoxRegister(
      {super.key, required this.isAgree, required this.onChanged});

  final bool? isAgree;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(value: isAgree, onChanged: onChanged),
            Column(
              children: [
                Row(
                  children: const [
                    Text(
                      'Saya menyutujui segala isi ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      'syarat',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: kGreen),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      'penggunaan ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: kGreen),
                    ),
                    Text(
                      'dan ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      'kebijakan privasi',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: kGreen),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
