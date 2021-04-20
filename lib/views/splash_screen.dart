import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF40BFFF),
      body: Center(
        child: Image.asset(
          "assets/icons/logo_white.png",
          width: MediaQuery.of(context).size.width * 0.25,
        ),
      ),
    );
  }
}
