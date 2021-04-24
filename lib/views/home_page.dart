import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tokotok/baseviews/card_product.dart';
import 'package:tokotok/baseviews/item_category.dart';
import 'package:tokotok/baseviews/offer_item.dart';
import 'package:tokotok/firebase/promos_database.dart';
import 'package:tokotok/models/product.dart';
import 'package:tokotok/views/custom_theme.dart';
import 'package:dots_indicator/dots_indicator.dart';

// ignore: must_be_immutable
class Homapage extends StatelessWidget {
  PageController offersController = new PageController();
  ValueNotifier<int> indexPage = ValueNotifier(0);
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
        elevation: 0.5,
        backgroundColor: CustomTheme.Background,
        actions: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
            child: TextFormField(
              style: TextStyle(fontSize: 14, color: CustomTheme.Dark),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: CustomTheme.Light, width: 1.5)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustomTheme.Blue)),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18,
                    color: CustomTheme.Blue,
                  )),
            ),
          )),
          IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: CustomTheme.Grey,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: CustomTheme.Grey,
              ),
              onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: PageView(
                onPageChanged: (index) {
                  indexPage.value = index;
                },
                controller: offersController,
                children: offers,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: indexPage,
              builder: (context, index, _) {
                return DotsIndicator(
                  dotsCount: offers.length,
                  position: index.toDouble(),
                  decorator: DotsDecorator(
                      activeColor: CustomTheme.Blue, color: CustomTheme.Grey),
                );
              },
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kategori",
                    style: CustomTheme.Title.copyWith(fontSize: 14),
                  ),
                  Text(
                    "Semua Kategori",
                    style: CustomTheme.Title.copyWith(
                        color: CustomTheme.Blue, fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  ItemCategory(
                    label: "Otomotif",
                    icon: Icon(
                      Icons.car_rental,
                      color: CustomTheme.Blue,
                    ),
                  ),
                  ItemCategory(
                    label: "Hobi",
                    icon: Icon(
                      Icons.agriculture_outlined,
                      color: CustomTheme.Blue,
                    ),
                  ),
                  ItemCategory(
                    label: "Komputer",
                    icon: Icon(
                      Icons.computer,
                      color: CustomTheme.Blue,
                    ),
                  ),
                  ItemCategory(
                    label: "Fotografi",
                    icon: Icon(
                      Icons.camera_alt,
                      color: CustomTheme.Blue,
                    ),
                  ),
                  ItemCategory(
                    label: "Makanan",
                    icon: Icon(
                      Icons.fastfood,
                      color: CustomTheme.Blue,
                    ),
                  ),
                  ItemCategory(
                    label: "Buku",
                    icon: Icon(
                      Icons.book,
                      color: CustomTheme.Blue,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Flash Sale",
                    style: CustomTheme.Title.copyWith(fontSize: 14),
                  ),
                  Text(
                    "Lihat Semua",
                    style: CustomTheme.Title.copyWith(
                        color: CustomTheme.Blue, fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 240,
              child: FutureBuilder(
                future: PromosDatabase.getPromo("wvFip99VCUHcMTtqKjr1"),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error Connection");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<Product> products = [];
                    List<QueryDocumentSnapshot> docs =
                        (snapshot.data as QuerySnapshot).docs;
                    docs.forEach((element) {
                      Map<String, dynamic> product = element.data();
                      products.add(Product(
                          id: element.id,
                          productName: product["productName"],
                          price: product["price"],
                          discount: product["discount"],
                          images: product["images"]));
                    });
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return CardProduct(
                          idProduct: products[index].id,
                          productName: products[index].productName,
                          price: products[index].price,
                          discount: products[index].discount,
                          img: products[index].images[0],
                        );
                      },
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Shimmer(
                        gradient: LinearGradient(colors: [
                          Colors.grey,
                          Colors.grey[100],
                          Colors.grey
                        ]),
                        child: CardProduct(
                          productName: "Loading",
                          price: 3000000,
                          discount: 0.24,
                          img: "productImages/no_photo.png",
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mega Sale",
                    style: CustomTheme.Title.copyWith(fontSize: 14),
                  ),
                  Text(
                    "Lihat Semua",
                    style: CustomTheme.Title.copyWith(
                        color: CustomTheme.Blue, fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 240,
              child: FutureBuilder(
                future: PromosDatabase.getPromo("GRUD4DlBMRv2Troy9qsY"),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error Connection");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<Product> products = [];
                    List<QueryDocumentSnapshot> docs =
                        (snapshot.data as QuerySnapshot).docs;
                    docs.forEach((element) {
                      Map<String, dynamic> product = element.data();
                      products.add(Product(
                          id: element.id,
                          productName: product["productName"],
                          price: product["price"],
                          discount: product["discount"],
                          images: product["images"]));
                    });
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return CardProduct(
                          idProduct: products[index].id,
                          productName: products[index].productName,
                          price: products[index].price,
                          discount: products[index].discount,
                          img: products[index].images[0],
                        );
                      },
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Shimmer(
                        gradient: LinearGradient(colors: [
                          Colors.grey,
                          Colors.grey[100],
                          Colors.grey
                        ]),
                        child: CardProduct(
                          productName: "Loading",
                          price: 3000000,
                          discount: 0.24,
                          img: "productImages/no_photo.png",
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
