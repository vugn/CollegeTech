import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_snapshots.dart';
import 'package:teknisi_app/app/data/repositories/firebase/orders/orders_functions.dart';
import 'package:teknisi_app/app/routes/app_pages.dart';
import 'package:teknisi_app/app/widgets/indicator.dart';

class DetailCrashController extends GetxController {
  Rx<TextEditingController> brandName = TextEditingController().obs;
  RxString brandNameText = ''.obs;
  Rx<TextEditingController> crashDesc = TextEditingController().obs;
  RxString crashDescText = ''.obs;
  final FirebaseOrdersFunctions firebaseOrdersFunctions =
      FirebaseOrdersFunctions();
  final FirebaseSnapshots firebaseSnapshots = FirebaseSnapshots();
  final dynamic brandResult = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    brandName = TextEditingController(text: brandNameText.value).obs;
    crashDesc = TextEditingController(text: crashDescText.value).obs;
    if (brandResult['brandData'] != null) {
      brandName.value.text = brandResult['brandData']['name'];
      brandNameText.value = brandResult['brandData']['name'];
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
        Get.toNamed(Routes.TECHNICIANLIST, arguments: {
          "technicianData": techniciansData,
          "brandName": brandName.value.text,
          "errorDesc": crashDesc.value.text,
          "skillName": brandResult['skillType'],
        });
      }
    }
    Indicator.closeLoading();
  }
}
