import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TextFormPassword extends StatelessWidget {
  const TextFormPassword(
      {super.key,
      required this.passwordController,
      required this.isPasswordShow,
      required this.onPressed});

  final TextEditingController passwordController;
  final bool isPasswordShow;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kata Sandi',
          style: kHeading7,
        ),
        const SizedBox(height: 5),
        TextField(
          controller: passwordController,
          onChanged: (query) {},
          obscureText: !isPasswordShow,
          decoration: InputDecoration(
            hintText: 'Kata Sandi',
            border:
                const OutlineInputBorder(borderSide: BorderSide(color: kGrey)),
            suffixIcon: IconButton(
                onPressed: onPressed,
                icon: Icon(
                    isPasswordShow ? Icons.visibility_off : Icons.visibility)),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}
