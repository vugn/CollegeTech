import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:teknisi_app/app/widgets/indicator.dart';

class FirebaseOrdersFunctions {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  void setOrder(
    String orderId,
    int status,
    String dateStart,
    String timeStart,
  ) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('orders')
          .doc(orderId)
          .update({
        "status": status,
        "date_start": dateStart,
        "time_start": timeStart
      });
    } catch (e) {
      Indicator.closeLoading();
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getTechnicianListFromSkills() async {
    try {
      var results = await _firebaseFirestore
          .collection('users')
          .where('skills', arrayContains: 'Air Conditioner')
          .get();
      return results.docs;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }
}
