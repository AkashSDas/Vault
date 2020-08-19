import 'package:flutter/material.dart';

// COLORS
final white = Color(0xFFE8EEF1);
final darkBlue = Color(0xFF1E3D58);
final mediumBlue = Color(0xFF057DCD);
final lightBlue = Color(0xFF43B0F1);

final text1 = white;
final text2 = darkBlue;

// GRADIENTS
final gradPrimary = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF0476D0),
    Color(0xFF088FFA),
    Color(0xFF35A4FB),
    Color(0xFF62B8FC),
  ],
  stops: [0.1, 0.4, 0.7, 0.9],
);

// FONT FAMILIES
final String openSans = 'OpenSans';
final String montseraat = 'Montseraat';
final String roboto = 'Roboto';

// TEXT STYLES
final loadingLogoTextStyle = TextStyle(
  color: white,
  fontFamily: openSans,
  fontSize: 80.0,
  fontWeight: FontWeight.w900,
);

final navBarTextStyle = TextStyle(
  color: white,
  fontFamily: openSans,
  fontSize: 38.0,
  fontWeight: FontWeight.w900,
);

final h1 = TextStyle(
  color: text1,
  fontFamily: montseraat,
  fontSize: 34.0,
  fontWeight: FontWeight.w900,
);

final h2 = TextStyle(
  color: text1,
  fontFamily: openSans,
  fontSize: 30.0,
  fontWeight: FontWeight.w800,
);

final h3 = TextStyle(
  color: text2,
  fontFamily: montseraat,
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
);

final h4 = TextStyle(
  color: text1,
  fontFamily: roboto,
  fontSize: 24.0,
  fontWeight: FontWeight.w400,
);

final labelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: openSans,
  fontSize: 24.0,
);

final hintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: openSans,
);

final dialogTitleTextStyle = TextStyle(
  color: text2,
  fontFamily: openSans,
  fontWeight: FontWeight.bold,
  fontSize: 26.0,
);

final dialogHintTextStyle = TextStyle(
  color: text2,
  fontFamily: roboto,
  fontSize: 22.0,
);

final boxDecorationStyle = BoxDecoration(
  color: Color(0xFF62B8FC),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
