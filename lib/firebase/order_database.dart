import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tokotok/firebase/auth_services.dart';

class OrderDatabase {
  static CollectionReference _order =
      FirebaseFirestore.instance.collection("orders");

  static Future<QuerySnapshot> getOrders() async {
    User user = await AuthServices.getCurrentUser();
    return _order.where("uid", isEqualTo: user.uid).get();
  }

  static Future<DocumentReference> addOrder(Map<String, dynamic> map) {
    return _order.add(map);
  }
}
