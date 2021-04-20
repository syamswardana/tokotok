import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsDatabase {
  static CollectionReference _products =
      FirebaseFirestore.instance.collection("products");

  static Future<QuerySnapshot> getAll() async {
    return await _products.get();
  }

  static Future<DocumentSnapshot> getProduct(String id) async {
    return await _products.doc(id).get();
  }
}
