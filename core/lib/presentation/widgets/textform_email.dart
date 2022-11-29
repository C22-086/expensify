import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TextFormEmail extends StatelessWidget {
  const TextFormEmail({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: kHeading7.copyWith(color: kSoftBlack),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          onChanged: (query) {},
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.email_outlined),
            hintText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: const BorderSide(
                color: kGrey,
              ),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}
