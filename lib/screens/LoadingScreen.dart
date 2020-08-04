import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../routes.dart';
import '../styles/global.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      // After some delay navigate to the home screen
      Navigator.pushReplacementNamed(context, home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: loadingScreenBg,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Vault',
                style: Headline1,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              ),
              SpinKitRing(
                color: loaderColor,
                size: 120.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
