import 'package:tokotok/models/product.dart';

class Order {
  final String id;
  final String addressId;
  final List<Product> products;
  final String status;
  Order({this.id, this.addressId, this.products, this.status});

  Map<String, dynamic> toMap() {
    return {
      "addressId": this.addressId,
      "products": this.products,
      "status": this.status
    };
  }
}
