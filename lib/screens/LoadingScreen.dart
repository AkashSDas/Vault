import 'package:flutter/material.dart';

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
      body: Container(
        decoration: BoxDecoration(gradient: gradPrimary),
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Text(
            'Vault',
            style: loadingLogoTextStyle,
          ),
        ),
      ),
    );
  }
}
