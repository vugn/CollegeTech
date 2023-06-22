import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_snapshots.dart';
import 'package:teknisi_app/app/data/repositories/firebase/orders/orders_functions.dart';
import 'package:teknisi_app/app/widgets/indicator.dart';

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

  RxBool isFilled() {
    if (brandName.value.text.isNotEmpty && crashDesc.value.text.isNotEmpty) {
      return true.obs;
    }
    return false.obs;
  }

  void findTechnician() async {
    if (isFilled().value) {
      Indicator.showLoading();
      var techniciansData = await firebaseOrdersFunctions
          .getTechnicianListFromSkills(brandResult['skillType']);
      if (techniciansData.isNotEmpty) {
        Indicator.closeLoading();
      }
    }
    Indicator.closeLoading();
  }
}
