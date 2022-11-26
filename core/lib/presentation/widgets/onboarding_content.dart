import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingContent extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  const OnboardingContent(
      {required this.imageUrl,
      required this.title,
      required this.description,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imageUrl,
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ),
        const SizedBox(height: 81),
      ],
    );
  }
}
