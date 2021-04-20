import 'package:flutter/cupertino.dart';

class ProductCart {
  final String id;
  final String idProduct;
  final String productName;
  final int price;
  final double discount;
  final int quantity;
  final String images;
  ProductCart(
      {@required this.id,
      @required this.idProduct,
      @required this.productName,
      @required this.price,
      @required this.discount,
      @required this.quantity,
      @required this.images});
}
