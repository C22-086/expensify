import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          style: kSubtitle.copyWith(
            fontSize: 14,
            color: kGreen,
          ),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(value: isAgree, onChanged: onChanged),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            child: RichText(
              maxLines: 2,
              text: TextSpan(
                text: 'Saya menyetujui segala isi ',
                style: kBodyText.copyWith(
                  fontSize: 12,
                  color: context.watch<ThemeBloc>().state ? kWhite : kDark,
                ),
                children: [
                  TextSpan(
                    text: 'syarat penggunaan ',
                    style: kBodyText.copyWith(
                      color: kGreen,
                      fontSize: 12,
                    ),
                  ),
                  TextSpan(
                    text: 'dan ',
                    style: kBodyText.copyWith(
                      fontSize: 12,
                      color: context.watch<ThemeBloc>().state ? kWhite : kDark,
                    ),
                  ),
                  TextSpan(
                    text: 'kebijakan privasi',
                    style: kBodyText.copyWith(
                      fontSize: 12,
                      color: kGreen,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
