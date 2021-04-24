import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF40BFFF),
      body: Center(
        child: SvgPicture.asset(
          "assets/icons/logo_white.svg",
          width: MediaQuery.of(context).size.width / 4,
        ),
      ),
    );
  }
}
