import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tokotok/baseviews/card_product.dart';
import 'package:tokotok/firebase/auth_services.dart';
import 'package:tokotok/firebase/cart_database.dart';
import 'package:tokotok/firebase/firestorage.dart';
import 'package:tokotok/firebase/products_database.dart';
import 'package:tokotok/views/custom_theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class ProductDetail extends StatelessWidget {
  final String idProduct;

  ProductDetail({this.idProduct});

  ValueNotifier<List<Map<String, dynamic>>> ukuran = ValueNotifier([
    {"var": "29", "selected": false},
    {"var": "31", "selected": false},
    {"var": "31", "selected": false}
  ]);

  ValueNotifier<List<Map<String, dynamic>>> warna = ValueNotifier([
    {"var": "Merah", "selected": false},
    {"var": "Kuning", "selected": false},
    {"var": "Hijau", "selected": false}
  ]);

  ValueNotifier<int> indexImage = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    TextStyle title = TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: CustomTheme.Dark);

    return FutureBuilder(
        future: ProductsDatabase.getProduct(idProduct),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error Connection"),
            );
          }
          Map<String, dynamic> product = snapshot.data.data();
          return Scaffold(
            backgroundColor: CustomTheme.Background,
            appBar: AppBar(
              backgroundColor: CustomTheme.Background,
              elevation: 1,
              leading: BackButton(
                color: CustomTheme.Grey,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                product["productName"],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: CustomTheme.Dark,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.more_vert_rounded,
                      color: CustomTheme.Grey,
                    ),
                    onPressed: () {})
              ],
            ),
            floatingActionButton: ElevatedButton(
              child: Text("Masukan Keranjang"),
              onPressed: () async {
                User user = await AuthServices.getCurrentUser();
                List<QueryDocumentSnapshot> docs =
                    await CartDatabase.searchCart(user.uid, this.idProduct);
                String msg = "error";
                if (docs.isNotEmpty) {
                  await CartDatabase.setQuantity(
                          docs.first.id, docs.first["quantity"] + 1)
                      .then((value) => msg = "Berhasil masukan ke keranjang")
                      .onError(
                          (error, stackTrace) => msg = "Gagal menambahkan");
                } else {
                  await CartDatabase.addCart(user.uid, idProduct)
                      .then((value) => msg = "Berhasil masukan ke keranjang")
                      .onError(
                          (error, stackTrace) => msg = "Gagal menambahkan");
                }
                SnackBar snackBar = SnackBar(content: Text(msg));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(CustomTheme.Blue),
                  minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width - 40, 50))),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      height: 200,
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 10),
                      child: PageView.builder(
                          itemCount: product["images"].length,
                          onPageChanged: (index) {
                            indexImage.value = index;
                          },
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                                future: FireStorage.downloadURLExample(
                                    product["images"][index] ??
                                        "productImages/no_photo.png"),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Image(
                                      image: NetworkImage(snapshot.data),
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                    );
                                  }
                                  return Shimmer(
                                    gradient: LinearGradient(colors: [
                                      Colors.grey,
                                      Colors.grey[100],
                                      Colors.grey
                                    ]),
                                    child: Image(
                                      image: AssetImage("assets/image_46.png"),
                                      height: 100,
                                      width: 100,
                                    ),
                                  );
                                });
                          })),
                  ValueListenableBuilder(
                    valueListenable: indexImage,
                    builder: (context, value, _) {
                      return DotsIndicator(
                        position: value.toDouble(),
                        dotsCount: product["images"].length,
                        decorator: DotsDecorator(
                            activeColor: CustomTheme.Blue,
                            color: CustomTheme.Light),
                      );
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 7,
                          child: Text(
                            product["productName"],
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: CustomTheme.Dark,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: CustomTheme.Grey,
                              ),
                              onPressed: () {}),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: RatingBar.builder(
                        initialRating: 4.0,
                        ignoreGestures: true,
                        unratedColor: Colors.amberAccent,
                        allowHalfRating: true,
                        itemSize: 18,
                        itemCount: 5,
                        itemBuilder: (context, _) {
                          return Icon(
                            Icons.star,
                            color: Colors.amber,
                          );
                        },
                        onRatingUpdate: (rating) {}),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      NumberFormat.currency(
                        locale: "id",
                        symbol: "Rp. ",
                        decimalDigits: 0,
                      ).format(product["price"]),
                      style: TextStyle(
                          color: CustomTheme.Blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Ukuran",
                      style: title,
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(left: 20, top: 10),
                    alignment: Alignment.centerLeft,
                    child: ValueListenableBuilder(
                      valueListenable: ukuran,
                      builder: (context, value, _) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(right: 10),
                                child: ChoiceChip(
                                  labelPadding: EdgeInsets.all(5),
                                  backgroundColor: CustomTheme.Background,
                                  side: BorderSide(
                                      color: value[index]["selected"]
                                          ? CustomTheme.Blue
                                          : CustomTheme.Light),
                                  label: Text(
                                    value[index]["var"],
                                    style: TextStyle(
                                        color: CustomTheme.Dark,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  selected: value[index]["selected"],
                                  onSelected: (bol) {
                                    // ukuran.value[index]["selected"] = bol;
                                    for (var i = 0; i < value.length; i++) {
                                      ukuran.value[i]["selected"] =
                                          i == index ? true : false;
                                    }
                                    ukuran.notifyListeners();
                                  },
                                ),
                              );
                            });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Warna",
                      style: title,
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(left: 20, top: 10),
                    alignment: Alignment.centerLeft,
                    child: ValueListenableBuilder(
                      valueListenable: warna,
                      builder: (context, value, _) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(right: 10),
                                child: ChoiceChip(
                                  labelPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  backgroundColor: CustomTheme.Background,
                                  side: BorderSide(
                                      color: value[index]["selected"]
                                          ? CustomTheme.Blue
                                          : CustomTheme.Light),
                                  label: Text(
                                    value[index]["var"],
                                    style: TextStyle(
                                        color: CustomTheme.Dark,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  selected: value[index]["selected"],
                                  onSelected: (bol) {
                                    // ukuran.value[index]["selected"] = bol;
                                    for (var i = 0; i < value.length; i++) {
                                      warna.value[i]["selected"] =
                                          i == index ? true : false;
                                    }
                                    warna.notifyListeners();
                                  },
                                ),
                              );
                            });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Deskripsi",
                      style: title,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: CustomTheme.Grey),
                          text:
                              "The Nike Air Max 270 React ENG combines a full-length React foam midsole with a 270 Max Air unit for unrivaled comfort and a striking visual experience."),
                      softWrap: true,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Review",
                          style: title,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Lihat semua",
                              style: TextStyle(
                                  color: CustomTheme.Blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Row(
                      children: [
                        RatingBar.builder(
                            initialRating: 4.0,
                            ignoreGestures: true,
                            unratedColor: Colors.amberAccent,
                            allowHalfRating: true,
                            itemSize: 16,
                            itemCount: 5,
                            itemBuilder: (context, _) {
                              return Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            },
                            onRatingUpdate: (rating) {}),
                        SizedBox(
                          width: 10,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "4.5 ",
                                style: TextStyle(
                                  color: CustomTheme.Grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                children: [
                              TextSpan(
                                  text: "(5 Review)",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal))
                            ]))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    height: 50,
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.pink),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "James Lawson",
                              style: title,
                            ),
                            RatingBar.builder(
                                initialRating: 4.0,
                                ignoreGestures: true,
                                unratedColor: Colors.amberAccent,
                                allowHalfRating: true,
                                itemSize: 16,
                                itemCount: 5,
                                itemBuilder: (context, _) {
                                  return Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  );
                                },
                                onRatingUpdate: (rating) {}),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: CustomTheme.Grey),
                          text:
                              "air max are always very comfortable fit, clean and just perfect in every way. just the box was too small and scrunched the sneakers up a little bit, not sure if the box was always this small but the 90s are and will always be one of my favorites."),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Terkait",
                          style: title,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 240,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CardProduct(
                          productName:
                              "FS - Nike Air Max 270 React lalalalalala",
                          price: 4000000,
                          discount: 0.5,
                          img: null,
                        ),
                        CardProduct(
                          productName: "FS - QUILTED MAXI CROS...",
                          price: 3000000,
                          discount: 0.2,
                          img: null,
                        ),
                        CardProduct(
                          productName: "FS - Nike Air Max 270 React...",
                          price: 3000000,
                          discount: 0.5,
                          img: null,
                        ),
                        CardProduct(
                          productName:
                              "FS - Nike Air Max 270 React lalalalalala",
                          price: 4000000,
                          discount: 0.24,
                          img: null,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          );
        });
  }
}
