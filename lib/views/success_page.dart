import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tokotok/views/custom_theme.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: CustomTheme.Blue,
              size: 180,
            ),
            Text(
              "Order Berhasil",
              style: TextStyle(
                  color: CustomTheme.Dark,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Terimakasih telah order",
              style: TextStyle(color: CustomTheme.Grey),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Kembali"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(CustomTheme.Blue),
                  minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width - 40, 50))),
            )
          ],
        ),
      ),
    );
  }
}
