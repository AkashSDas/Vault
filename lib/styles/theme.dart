import 'package:flutter/material.dart';

// COLORS
const Color black = Color(0xFF000000);
const Color white = Color(0xFFFFFFFF);
const Color purple = Color(0xFF6000FF);
const Color pink = Color(0xFFCC00FF);
const Color gray = Color(0xFF43424B);
const Color yellow = Color(0xFFFAFF03);
const Color green = Color(0xFF06C20D);
const Color orange = Color(0xFFFF9900);
const Color red = Color(0xFFFF4343);

const Color text1 = white;
const Color text2 = Colors.white54;

const Color bgPrimary = black;
const Color bgSecondary = gray;

const Color loaderColor = purple;

// FONT FAMILIES
const String openSans = 'OpenSans';
const String montseraat = 'Montseraat';
const String roboto = 'Roboto';

// TEXT STYLES
const TextStyle loadingLogoTextStyle = TextStyle(
  color: white,
  fontFamily: openSans,
  fontSize: 80.0,
  fontWeight: FontWeight.w900,
  fontStyle: FontStyle.italic,
);

const TextStyle navBarTextStyle = TextStyle(
  color: white,
  fontFamily: openSans,
  fontSize: 38.0,
  fontWeight: FontWeight.w900,
  fontStyle: FontStyle.italic,
);

const TextStyle h1 = TextStyle(
  color: text1,
  fontFamily: openSans,
  fontSize: 32.0,
  fontWeight: FontWeight.w800,
);

const TextStyle h2 = TextStyle(
  color: text1,
  fontFamily: montseraat,
  fontSize: 28.0,
  fontWeight: FontWeight.w700,
);

const TextStyle h3 = TextStyle(
  color: text1,
  fontFamily: roboto,
  fontSize: 26.0,
);

const TextStyle h4 = TextStyle(
  color: text2,
  fontFamily: montseraat,
  fontSize: 26.0,
);
