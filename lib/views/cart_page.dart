import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tokotok/views/custom_theme.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Keranjang Anda",
            style: CustomTheme.Title,
          ),
          backgroundColor: CustomTheme.Background,
          elevation: 0.5,
        ),
        body: Container(
          child: ListView(
            children: [
              ItemCart(
                productName: "Nike Air Zoom Pegasus 36 Miami",
                image: Image.asset(
                  "assets/image_47.png",
                  height: 80,
                ),
                price: 2000000,
                favorite: true,
              ),
              ItemCart(
                productName: "Nike Air Zoom Pegasus 36 Miami",
                image: Image.asset(
                  "assets/image_49.png",
                  height: 80,
                ),
                price: 2000000,
                favorite: false,
              )
            ],
          ),
        ));
  }
}

class ItemCart extends StatelessWidget {
  final String productName;
  final Widget image;
  final int price;
  final int quantity;
  final bool favorite;
  ItemCart(
      {this.productName,
      this.image,
      this.price,
      this.quantity = 1,
      this.favorite = false});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      semanticContainer: false,
      child: Container(
        height: 80,
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            image,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 7.5),
                        width: 150,
                        child: Text(
                          productName,
                          style: TextStyle(
                              color: CustomTheme.Dark,
                              fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () {},
                          child: !favorite
                              ? Icon(
                                  Icons.favorite_border,
                                  color: CustomTheme.Grey,
                                )
                              : Icon(
                                  Icons.favorite,
                                  color: CustomTheme.Red,
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Material(
                        type: MaterialType.circle,
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.delete,
                            color: CustomTheme.Grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 7.5),
                        child: Text(
                          NumberFormat.currency(
                                  locale: "id",
                                  decimalDigits: 0,
                                  symbol: "Rp. ")
                              .format(price),
                          style: TextStyle(
                              color: CustomTheme.Blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 25,
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: CustomTheme.Grey),
                                ),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: CustomTheme.Light)),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: CustomTheme.Light),
                                    top: BorderSide(color: CustomTheme.Light)),
                                color: CustomTheme.Light),
                            child: TextField(
                              controller: new TextEditingController(text: "1"),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              scrollPadding: EdgeInsets.zero,
                              decoration: InputDecoration(
                                  border: InputBorder.none, isDense: true),
                            ),
                          ),
                          Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 25,
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: CustomTheme.Grey),
                                ),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: CustomTheme.Light)),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
