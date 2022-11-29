import 'package:core/core.dart';
import 'package:flutter/material.dart';

class GeneralForm extends StatelessWidget {
  const GeneralForm(
      {super.key,
      required this.controller,
      required this.label,
      required this.hint,
      required this.textInputType,
      required this.icon});

  final TextEditingController controller;

  final String label;
  final String hint;
  final TextInputType textInputType;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kHeading7,
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          onChanged: (query) {},
          decoration: InputDecoration(
            prefixIcon: icon,
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: const BorderSide(
                color: kGrey,
              ),
            ),
          ),
          keyboardType: textInputType,
        ),
      ],
    );
  }
}
