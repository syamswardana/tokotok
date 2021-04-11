import 'package:flutter/material.dart';
import 'package:tokotok/baseviews/offer_item.dart';
import 'package:tokotok/views/custom_theme.dart';

class OffersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<OfferItem> offers = [];
    offers.add(OfferItem(
      title: "Super Flash Sale",
      subtitle: "30 Maret sampai 2 April",
      color: CustomTheme.Blue,
    ));
    offers.add(OfferItem(
      title: "Mega Electronic Sale",
      subtitle: "30 Maret sampai 2 April",
      color: CustomTheme.Purple,
    ));
    offers.add(OfferItem(
      title: "Mandiri Discount",
      subtitle: "30 Maret sampai 2 April",
      color: CustomTheme.Yellow,
    ));
    return Scaffold(
      backgroundColor: CustomTheme.Background,
      appBar: AppBar(
        title: Text(
          "Offers",
          style: TextStyle(color: CustomTheme.Dark),
        ),
        elevation: 0.5,
        backgroundColor: CustomTheme.Background,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: offers.length,
          itemBuilder: (context, index) {
            return Container(
              height: 200,
              margin: EdgeInsets.only(bottom: 10),
              child: offers[index],
            );
          }),
    );
  }
}
