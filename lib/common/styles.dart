import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFFFFFFF);
const Color secondaryColor = Color(0xFFF57C00);

final textTheme = TextTheme(
  headline1: GoogleFonts.raleway(
      fontSize: 98, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.raleway(
      fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.raleway(fontSize: 49, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.raleway(
      fontSize: 35, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.raleway(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.raleway(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.raleway(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.raleway(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.lato(
      fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.lato(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.lato(
      fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.lato(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.lato(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
