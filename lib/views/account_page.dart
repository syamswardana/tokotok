import 'package:flutter/material.dart';
import 'package:tokotok/firebase/auth_services.dart';
import 'package:tokotok/views/custom_theme.dart';
import 'package:tokotok/views/order_page.dart';
import 'package:tokotok/views/shiping_page.dart';
import 'package:tokotok/views/success_page.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ButtonStyle menuStyle = ButtonStyle(
      alignment: Alignment.centerLeft,
      visualDensity: VisualDensity.standard,
      minimumSize: MaterialStateProperty.all(Size(double.infinity, 60)),
    );
    return Scaffold(
      backgroundColor: CustomTheme.Background,
      appBar: AppBar(
        backgroundColor: CustomTheme.Background,
        elevation: 0.5,
        title: Text(
          "Akun",
          style: TextStyle(color: CustomTheme.Dark),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            TextButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Fitur belum tersedia")));
              },
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
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return OrderPage();
                }));
              },
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
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ShippingPage(
                    isManage: true,
                  );
                }));
              },
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
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Fitur belum tersedia")));
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) {
                //   return SuccessPage();
                // }));
              },
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
            TextButton.icon(
              onPressed: () async {
                await AuthServices.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: CustomTheme.Red,
              ),
              label: Text(
                "Logout",
                style: TextStyle(color: CustomTheme.Dark),
              ),
              style: menuStyle,
            )
          ],
        ),
      ),
    );
  }
}
