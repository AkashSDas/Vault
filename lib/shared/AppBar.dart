import 'package:flutter/material.dart';

import '../styles/global.dart';

PreferredSize getAppBar(String title, bool center) {
  Text navBarText = Text(title, style: Headline2);
  dynamic navBarItem = center ? Center(child: navBarText) : navBarText;

  return PreferredSize(
    preferredSize: Size.fromHeight(80.0),
    child: AppBar(
      title: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 25.0),
          ),
          navBarItem,
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(30.0, 40.0),
          bottomRight: Radius.elliptical(30.0, 40.0),
        ),
      ),
      backgroundColor: navBar,
    ),
  );
}
