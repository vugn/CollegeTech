import 'package:flutter/cupertino.dart';
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
}
