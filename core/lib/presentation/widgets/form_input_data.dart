import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core.dart';

class FormInputData extends StatelessWidget {
  final TextEditingController controller;
  final String chipLabel;
  final String? hintText;

  const FormInputData({
    super.key,
    required this.controller,
    required this.chipLabel,
    this.hintText,
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
        color: kWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            offset: Offset(3, 3),
            spreadRadius: -10,
            blurRadius: 49,
            color: Color.fromARGB(255, 169, 169, 169),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Chip(
            backgroundColor: Colors.transparent,
            labelStyle: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: kGreen,
            ),
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: kGreen, width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            label: Text(chipLabel),
          ),
          const SizedBox(height: 9),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(14),
              ),
              fillColor: const Color(0xffF7F8F8),
              hintText: hintText,
              filled: true,
              hintStyle: GoogleFonts.poppins(
                fontSize: 12,
              ),
            ),
            controller: controller,
          )
        ],
      ),
    );
  }
}
