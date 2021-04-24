import 'package:cloud_firestore/cloud_firestore.dart';

class CartDatabase {
  static CollectionReference _cart =
      FirebaseFirestore.instance.collection("cart");

  static Future<List<QueryDocumentSnapshot>> getCart(String uid) async {
    QuerySnapshot snapshot = await _cart.where("uid", isEqualTo: uid).get();
    List<QueryDocumentSnapshot> docs = snapshot.docs;
    return docs;
  }

  static Future<List<QueryDocumentSnapshot>> searchCart(
      String uid, String idProduct) async {
    QuerySnapshot snapshot = await _cart
        .where("uid", isEqualTo: uid)
        .where("idProduct", isEqualTo: idProduct)
        .get();
    List<QueryDocumentSnapshot> docs = snapshot.docs;
    return docs;
  }

  static Future<void> setQuantity(String idCart, int quantity) async {
    return _cart.doc(idCart).update({"quantity": quantity});
  }

  static Future<void> addCart(String uid, String idProduct) async {
    return _cart.add({"uid": uid, "idProduct": idProduct, "quantity": 1});
  }

  static Future<void> deleteCart(String id) async {
    return _cart.doc(id).delete();
  }

  static Future<void> batchDelete(String uid) {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    return _cart.where("uid", isEqualTo: uid).get().then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });

      return batch.commit();
    });
  }
}
