import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_snapshots.dart';
import 'package:teknisi_app/app/data/repositories/firebase/orders/orders_functions.dart';

class DetailCrashController extends GetxController {
  final Rx<TextEditingController> brandName = TextEditingController().obs;
  final Rx<TextEditingController> crashDesc = TextEditingController().obs;
  final FirebaseOrdersFunctions firebaseOrdersFunctions =
      FirebaseOrdersFunctions();
  final FirebaseSnapshots firebaseSnapshots = FirebaseSnapshots();
  final dynamic brandResult = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    if (brandResult['brandData'] != null) {
      brandName.value.text = brandResult['brandData']['name'];
    }
  }
}
