import 'package:flutter/cupertino.dart';

class Product {
  final String id;
  final String productName;
  final int price;
  final double discount;
  final List<dynamic> images;
  Product(
      {@required this.id,
      @required this.productName,
      @required this.price,
      @required this.discount,
      @required this.images});
}
