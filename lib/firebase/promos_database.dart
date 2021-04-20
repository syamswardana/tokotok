import 'package:cloud_firestore/cloud_firestore.dart';

class PromosDatabase {
  static CollectionReference _promos =
      FirebaseFirestore.instance.collection("promos");

  static Future<QuerySnapshot> getAll() async {
    return await _promos.get();
  }

  static Future<QuerySnapshot> getPromo(String id) async {
    DocumentSnapshot doc = await _promos.doc(id).get();
    var promo = doc.data();
    return FirebaseFirestore.instance
        .collection("products")
        .where(FieldPath.documentId, whereIn: (promo["products"] as List))
        .get();
  }
}
