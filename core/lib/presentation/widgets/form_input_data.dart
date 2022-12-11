import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core.dart';

class FormInputData extends StatelessWidget {
  final TextEditingController controller;
  final String chipLabel;
  final String? hintText;
  final Color boderColor;
  final Color textColor;
  final TextInputType keyboardType;

  const FormInputData({
    super.key,
    required this.controller,
    required this.chipLabel,
    this.hintText,
    this.boderColor = kGreen,
    this.textColor = kGreen,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: context.watch<ThemeBloc>().state ? kDark : kWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            offset: const Offset(3, 3),
            spreadRadius: -10,
            blurRadius: 49,
            color: context.watch<ThemeBloc>().state
                ? kDark
                : const Color.fromARGB(255, 236, 236, 236),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Chip(
            backgroundColor: Colors.transparent,
            labelStyle: kHeading6.copyWith(fontSize: 10, color: kGreen),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: boderColor, width: 2),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            label: Text(chipLabel),
          ),
          const SizedBox(height: 9),
          TextFormField(
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Tidak boleh kosong';
              }
              return null;
            },
            keyboardType: keyboardType,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(14),
                ),
                fillColor: context.watch<ThemeBloc>().state
                    ? kSoftDark
                    : const Color(0xffF7F8F8),
                hintText: hintText,
                filled: true,
                hintStyle: kHeading6.copyWith(fontSize: 12)),
            controller: controller,
          )
        ],
      ),
    );
  }
}
