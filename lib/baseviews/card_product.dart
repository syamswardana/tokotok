import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tokotok/firebase/firestorage.dart';
import 'package:tokotok/views/custom_theme.dart';
import 'package:tokotok/views/product_detail.dart';

class CardProduct extends StatelessWidget {
  final String idProduct;
  final String productName;
  final String img;
  final int price;
  final double discount;
  CardProduct(
      {this.idProduct, this.productName, this.price, this.discount, this.img});
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ProductDetail(
              idProduct: idProduct,
            );
          }));
        },
        child: Container(
          margin: EdgeInsets.only(right: 10),
          child: Card(
            elevation: 2,
            child: Container(
              padding: EdgeInsets.all(15),
              height: 240,
              width: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                      future: FireStorage.downloadURLExample(
                          img ?? "productImages/no_photo.png"),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Image(
                            image: NetworkImage(snapshot.data),
                            height: 100,
                            width: 100,
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
                      }),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    productName,
                    style: TextStyle(
                        color: CustomTheme.Dark, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    NumberFormat.currency(
                            locale: "id", symbol: "Rp. ", decimalDigits: 0)
                        .format(price * (1 - discount)),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: CustomTheme.Blue, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                      text: TextSpan(
                          text: NumberFormat.currency(
                                  locale: "id",
                                  symbol: "Rp. ",
                                  decimalDigits: 0)
                              .format(price),
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: CustomTheme.Grey,
                              fontSize: 12,
                              height: 1.5),
                          children: [
                        TextSpan(
                            text:
                                " " + (discount * 100).toInt().toString() + "%",
                            style: TextStyle(
                                color: CustomTheme.Red,
                                decoration: TextDecoration.none))
                      ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
