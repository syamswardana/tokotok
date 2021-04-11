import 'package:flutter/material.dart';
import 'package:tokotok/views/custom_theme.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ButtonStyle menuStyle = ButtonStyle(
      alignment: Alignment.centerLeft,
      visualDensity: VisualDensity.compact,
      minimumSize: MaterialStateProperty.all(Size(double.infinity, 60)),
    );
    return Scaffold(
      backgroundColor: CustomTheme.Background,
      appBar: AppBar(
        backgroundColor: CustomTheme.Background,
        elevation: 0.5,
        title: Text(
          "Akun",
          style: CustomTheme.Title.copyWith(fontSize: 14),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.person_outline,
                color: CustomTheme.Blue,
              ),
              label: Text(
                "Profil",
                style: TextStyle(color: CustomTheme.Dark),
              ),
              style: menuStyle,
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.date_range,
                color: CustomTheme.Blue,
              ),
              label: Text(
                "Order",
                style: TextStyle(color: CustomTheme.Dark),
              ),
              style: menuStyle,
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.location_pin,
                color: CustomTheme.Blue,
              ),
              label: Text(
                "Address",
                style: TextStyle(color: CustomTheme.Dark),
              ),
              style: menuStyle,
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.mobile_friendly_outlined,
                color: CustomTheme.Blue,
              ),
              label: Text(
                "Payment",
                style: TextStyle(color: CustomTheme.Dark),
              ),
              style: menuStyle,
            ),
          ],
        ),
      ),
    );
  }
}
