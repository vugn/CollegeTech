import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseOrdersFunctions {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getListOrdersTechnician() async {
    try {
      QuerySnapshot<Map<String, dynamic>> orders = await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('orders')
          .where('status', isEqualTo: 0)
          .get();
      return orders.docs;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }
}
