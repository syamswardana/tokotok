import 'package:flutter/material.dart';
import 'package:tokotok/views/home_page.dart';
import 'package:tokotok/views/login_form.dart';
import 'package:tokotok/views/login_page.dart';
import 'package:tokotok/views/navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigation(),
    );
  }
}

class Splash extends StatelessWidget {
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
