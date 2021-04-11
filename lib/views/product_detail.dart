import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:tokotok/baseviews/card_product.dart';
import 'package:tokotok/views/custom_theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle title = TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: CustomTheme.Dark);
    List<String> ukuran = ["29", "30", "31"];
    List<String> warna = ["Merah", "Kuning", "Hijau"];
    return Scaffold(
      backgroundColor: CustomTheme.Background,
      appBar: AppBar(
        backgroundColor: CustomTheme.Background,
        elevation: 1,
        leading: BackButton(
          color: CustomTheme.Grey,
        ),
        title: Text(
          "Nike Air Zoom Pegasus 36 Miami",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 10),
              child: PageView(
                children: [
                  Image.asset(
                    "assets/product_image.png",
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
            DotsIndicator(
              dotsCount: 5,
              decorator: DotsDecorator(
                  activeColor: CustomTheme.Blue, color: CustomTheme.Light),
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
                      "Nike Air Zoom Pegasus 36 Miami",
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
                "Rp. 2.000.000",
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
              height: 50,
              margin: EdgeInsets.only(left: 20, top: 10),
              alignment: Alignment.centerLeft,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: ukuran.length,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        ukuran[index],
                        style: title,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: CustomTheme.Light),
                          shape: BoxShape.circle),
                    );
                  }),
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
              height: 50,
              margin: EdgeInsets.only(left: 20, top: 10),
              alignment: Alignment.centerLeft,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: warna.length,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        warna[index],
                        style: title,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: CustomTheme.Light),
                          borderRadius: BorderRadius.circular(10)),
                    );
                  }),
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
                            style: TextStyle(fontWeight: FontWeight.normal))
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
                    productName: "FS - Nike Air Max 270 React lalalalalala",
                    price: 4000000,
                    discount: 50,
                    img: AssetImage("assets/image_46.png"),
                  ),
                  CardProduct(
                    productName: "FS - QUILTED MAXI CROS...",
                    price: 3000000,
                    discount: 24,
                    img: AssetImage("assets/image_54.png"),
                  ),
                  CardProduct(
                    productName: "FS - Nike Air Max 270 React...",
                    price: 3000000,
                    discount: 50,
                    img: AssetImage("assets/image_49.png"),
                  ),
                  CardProduct(
                    productName: "FS - Nike Air Max 270 React lalalalalala",
                    price: 4000000,
                    discount: 24,
                    img: AssetImage("assets/image_46.png"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
