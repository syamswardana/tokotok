import 'package:cloud_firestore/cloud_firestore.dart';

class AddressDatabase {
  static CollectionReference _address =
      FirebaseFirestore.instance.collection("address");

  static Future<List<QueryDocumentSnapshot>> getAddress(String uid) async {
    var data = await _address.where("uid", isEqualTo: uid).get();
    return data.docs;
  }

  static Future<DocumentReference> addAddress(Map<String, dynamic> map) {
    return _address.add(map);
  }

  static Future<void> deleteAddress(String id) {
    return _address.doc(id).delete();
  }

  static Future<void> updateAddress(String id, Map<String, dynamic> map) {
    return _address.doc(id).update(map);
  }
}
