import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:teknisi_app/app/data/constants.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_functions.dart';
import 'package:teknisi_app/app/widgets/indicator.dart';

class FirebaseOrdersFunctions {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions();

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

  Future<Map<String, dynamic>?> getUserOder(String orderId) async {
    try {
      var orders = await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('orders')
          .doc(orderId)
          .get();
      return orders.data();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  void setOrder(
    String orderId,
    String userId,
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
      //
      await _firebaseFirestore
          .collection('users')
          .doc(userId)
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

  void setOrderStatus(
    String orderId,
    String userId,
    int status,
  ) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('orders')
          .doc(orderId)
          .update({
        "status": status,
      });
      //
      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .update({
        "status": status,
      });
    } catch (e) {
      Indicator.closeLoading();
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getTechnicianListFromSkills(String skill) async {
    try {
      var results = await _firebaseFirestore
          .collection('users')
          .where('skills', arrayContains: skill)
          .get();
      return results.docs;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  Future<String> createOrder(
      {required String userId,
      required String technicianId,
      required String address,
      required String brand,
      required String dateStart,
      required String descError,
      required String latlng,
      required int status,
      required String timeStart,
      required String title,
      required dynamic toTechnician,
      required String userEmail}) async {
    try {
      String orderId = generateId();
      var userDataQuery = await _firebaseFunctions.getUserCredential(userEmail);
      var userData = userDataQuery!.docs[0].data();
      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .set({
        "address": address,
        "brand": brand,
        "date_start": dateStart,
        "desc_error": descError,
        "latlng": latlng,
        "status": status,
        "order_id": orderId,
        "time_start": timeStart,
        "title": title,
        "to_technician": toTechnician,
      });
      //
      await _firebaseFirestore
          .collection('users')
          .doc(technicianId)
          .collection('orders')
          .doc(orderId)
          .set({
        "address": address,
        "brand": brand,
        "date_start": dateStart,
        "desc_error": descError,
        "latlng": latlng,
        "status": status,
        "order_id": orderId,
        "time_start": timeStart,
        "title": title,
        "to_user": userData,
      });
      return orderId;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Indicator.closeLoading();
      return '';
    }
  }
}
