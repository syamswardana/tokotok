import 'package:flutter/material.dart';
import 'package:tokotok/views/account_page.dart';
import 'package:tokotok/views/cart_page.dart';
import 'package:tokotok/views/custom_theme.dart';
import 'package:tokotok/views/explore_page.dart';
import 'package:tokotok/views/home_page.dart';
import 'package:tokotok/views/offers_page.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int indexPage = 0;
  List<Widget> pages = [
    Homapage(),
    ExplorePage(),
    CartPage(),
    OffersPage(),
    AccountPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[indexPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: indexPage,
        selectedFontSize: 12,
        selectedItemColor: CustomTheme.Blue,
        selectedIconTheme: IconThemeData(color: CustomTheme.Blue),
        unselectedItemColor: CustomTheme.Grey,
        unselectedIconTheme: IconThemeData(color: CustomTheme.Grey),
        onTap: (index) {
          setState(() {
            indexPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "Beranda"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: "Jelajah"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              label: "Keranjang"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.article_outlined,
              ),
              label: "Promo"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
              ),
              label: "Akun")
        ],
      ),
    );
  }
}
