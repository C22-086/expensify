import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TextFormEmail extends StatelessWidget {
  const TextFormEmail({super.key, required this.emailController});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: kHeading7,
        ),
        const SizedBox(height: 5),
        TextField(
          controller: emailController,
          onChanged: (query) {},
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.email_outlined),
            hintText: 'Email',
            border: OutlineInputBorder(borderSide: BorderSide(color: kGrey)),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}
