import 'dart:math';

import 'package:flutter/material.dart';

// ****** COLORS ******
const Color white = Color(0xFFF6F7F7);
const Color black = Color(0xFF040404);
const Color gray1 = Color(0xFFADCBCE);
const Color gray2 = Color(0xFFF4F5F6);
const Color blue = Color(0xFF1681AF);
const Color yellow = Color(0xFFE19F10);
const Color red = Color(0xFFD4212D);
const Color green = Color(0xFF3B8C59);
const Color lightBlue = Color(0xFF57AAC3);
const Color lightGreen = Color(0xFF09c372);
const Color lightRed = Color(0xFFff3860);

// Texts
const Color text1 = blue;
const Color text2 = white;
const Color text3 = black;

// Loading Screen
const LinearGradient loadingScreenBg = LinearGradient(
  begin: Alignment.centerRight,
  end: Alignment.centerLeft,
  colors: [white, white],
);
const Color loaderColor = blue;

// Home Screen
const Color navBar = blue;
const Color homeScrenBg = white;

Color getRandomColor() {
  List<Color> cardBgColors = [yellow, red, green, lightBlue];
  var num = Random().nextInt(cardBgColors.length);
  return cardBgColors[num];
}

// Account Detail Screen
const Color detailScreenBg = white;
const Color detailCardBg = gray2;

// ****** Icons ******

// Form btn icons
const Color formBtnIconColor = white;

// ****** FONT FAMILIES ******
const String Yeseva = 'YesevaOne';
const String Josefin = 'Josefin';
const String NotoSansJP = 'NotoSansJP';

// ****** FONT SIZES ******
const LargeTextSize = 80.0;
const MediumTexSize = 40.0;
const SmallTextSize = 20.0;
const BodyTextSize = 24.0;
const BtnTextSize1 = 15.0;

// ****** TEXT STYLE ******
const Headline1 = TextStyle(
  color: text1,
  fontFamily: Yeseva,
  fontSize: LargeTextSize,
  fontWeight: FontWeight.bold,
);

const Headline2 = TextStyle(
  color: text2,
  fontFamily: Yeseva,
  fontSize: MediumTexSize,
  fontWeight: FontWeight.bold,
);

const FormText = TextStyle(
  color: text3,
  fontFamily: NotoSansJP,
  fontSize: SmallTextSize,
  fontWeight: FontWeight.bold,
);

const FormBtn = TextStyle(
  color: text2,
  fontFamily: Josefin,
  fontSize: BtnTextSize1,
  fontWeight: FontWeight.bold,
);

const Label = TextStyle(
  color: text3,
  fontFamily: Josefin,
  fontSize: SmallTextSize,
  fontWeight: FontWeight.bold,
);

const BodyText = TextStyle(
  color: text3,
  fontFamily: Josefin,
  fontSize: BodyTextSize,
  fontWeight: FontWeight.bold,
);

const CardText = TextStyle(
  color: text2,
  fontFamily: Josefin,
  fontSize: BodyTextSize,
  fontWeight: FontWeight.bold,
);
