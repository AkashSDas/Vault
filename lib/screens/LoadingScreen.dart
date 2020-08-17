import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../routes.dart';
import '../styles/theme.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  navigateToHomeScreen() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      // After some delay navigate to the home screen
      Navigator.pushReplacementNamed(context, home);
    });
  }

  @override
  void initState() {
    super.initState();
    this.navigateToHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimary,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Vault',
                style: loadingLogoTextStyle,
              ),
              SizedBox(
                height: 80,
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
