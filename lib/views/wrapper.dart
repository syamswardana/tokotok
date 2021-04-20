import 'package:flutter/material.dart';
import 'package:tokotok/firebase/auth_services.dart';
import 'package:tokotok/views/login_page.dart';
import 'package:tokotok/views/navigation.dart';
import 'package:tokotok/views/splash_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthServices.firebaseUserStream,
        builder: (context, user) {
          if (user.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          if (user.hasData) {
            return Navigation();
          } else {
            return LoginPage();
          }
        });
  }
}
