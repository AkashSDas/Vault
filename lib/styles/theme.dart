import 'package:flutter/material.dart';

// COLORS
const Color black = Color(0xFF000000);
const Color white = Color(0xFFFFFFFF);
const Color purple = Color(0xFF6000FF);
const Color pink = Color(0xFFCC00FF);
const Color gray = Color(0xFF43424B);
const Color yellow = Color(0xFFFAFF03);
const Color green = Color(0xFF09FF12);
const Color orange = Color(0xFFFF9900);

const Color text = white;

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
  fontSize: 30.0,
  fontWeight: FontWeight.w900,
  fontStyle: FontStyle.italic,
);

const TextStyle h1 = TextStyle(
  color: white,
  fontFamily: openSans,
  fontSize: 32.0,
  fontWeight: FontWeight.w800,
);

const TextStyle h2 = TextStyle(
  color: white,
  fontFamily: montseraat,
  fontSize: 28.0,
  fontWeight: FontWeight.w700,
);

const TextStyle h3 = TextStyle(
  color: white,
  fontFamily: roboto,
  fontSize: 26.0,
);

const TextStyle h4 = TextStyle(
  color: white,
  fontFamily: montseraat,
  fontSize: 24.0,
);
