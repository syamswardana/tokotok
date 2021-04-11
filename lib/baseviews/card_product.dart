import 'package:flutter/material.dart';
import 'package:tokotok/views/custom_theme.dart';

class CardProduct extends StatelessWidget {
  final String productName;
  final ImageProvider img;
  final int price;
  final int discount;
  CardProduct({this.productName, this.price, this.discount, this.img});
  @override
  Widget build(BuildContext context) {
    return Container(
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
              Image(
                image: img == null ? AssetImage("assets/image_46.png") : img,
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                productName,
                style: CustomTheme.Title.copyWith(fontSize: 14),
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Rp " + (price * discount ~/ 100).toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: CustomTheme.Blue, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                      text: "Rp " + price.toString(),
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: CustomTheme.Grey,
                          fontSize: 12,
                          height: 1.5),
                      children: [
                    TextSpan(
                        text: " " + discount.toString() + "%",
                        style: TextStyle(
                            color: CustomTheme.Red,
                            decoration: TextDecoration.none))
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
