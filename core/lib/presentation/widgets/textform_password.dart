import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFormPassword extends StatelessWidget {
  const TextFormPassword({
    super.key,
    required this.passwordController,
    required this.isPasswordShow,
    required this.onPressed,
  });

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
          style: kHeading7.copyWith(
            color: context.watch<ThemeBloc>().state ? kWhite : kDark,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: passwordController,
          onChanged: (query) {},
          obscureText: !isPasswordShow,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            hintText: 'Kata Sandi',
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: kGrey),
                borderRadius: BorderRadius.circular(defaultRadius)),
            suffixIcon: IconButton(
              onPressed: onPressed,
              icon: Icon(
                isPasswordShow ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}
