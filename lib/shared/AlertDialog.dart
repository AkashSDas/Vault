import 'package:flutter/material.dart';

import '../styles/theme.dart';

void showAlertDialog(BuildContext context, String title, String message) {
  Dialog alertDialog = Dialog(
    // backgroundColor: bgSecondary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Container(
      height: 200.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(title, style: dialogTitleTextStyle),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(message, style: dialogHintTextStyle),
          ),
        ],
      ),
    ),
  );
  showDialog(context: context, builder: (_) => alertDialog);
}
