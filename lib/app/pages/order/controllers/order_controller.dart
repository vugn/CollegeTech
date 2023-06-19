import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/data/repositories/firebase/orders/orders_functions.dart';

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final FirebaseOrdersFunctions firebaseOrdersFunctions =
      FirebaseOrdersFunctions();
  late Rx<TabController> tabBarController;
  RxInt currentTabIndex = 0.obs;

  @override
  void onInit() {
    tabBarController = TabController(vsync: this, length: 2).obs;
    super.onInit();
  }

  @override
  void onClose() {
    tabBarController.value.dispose();
    super.onClose();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getOrders() async {
    try {
      var orders = await firebaseOrdersFunctions.getListOrdersTechnician();
      return orders;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }
}
