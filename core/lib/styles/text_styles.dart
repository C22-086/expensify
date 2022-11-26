// text style
import 'package:core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextStyle kTitle = GoogleFonts.poppins(
    fontSize: 32, fontWeight: FontWeight.w400, color: kGreen);
final TextStyle kHeading5 =
    GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w700);
final TextStyle kHeading6 = GoogleFonts.poppins(
    fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.15);
final TextStyle kHeading7 =
    GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500);
final TextStyle kSubtitle = GoogleFonts.poppins(
    fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15);
final TextStyle kBodyText = GoogleFonts.poppins(
    fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey);

// text theme
final kTextTheme = TextTheme(
  headline5: kHeading5,
  headline6: kHeading6,
  subtitle1: kSubtitle,
  bodyText2: kBodyText,
);

// margin
const double defaultMargin = 20.0;
// padding
const double defaultPadding = 20.0;
