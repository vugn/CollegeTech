import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/widgets/indicator.dart';

import '../../../../data/repositories/firebase/firebase_auth.dart';
import '../../../../data/repositories/google_maps/maps_functions.dart';

class LoginController extends GetxController {
  final Rx<TextEditingController> emailLoginController =
      TextEditingController().obs;
  final Rx<TextEditingController> passwordLoginController =
      TextEditingController().obs;

  RxBool isUserActive = true.obs;
  RxBool isTechnicianActive = false.obs;

  RxBool isEmailCorrect = false.obs;
  RxBool isPasswordCorrect = false.obs;

  final FirebaseAuthentication _authentication = FirebaseAuthentication();
  final GoogleMapsFunctions _googleMapsFunctions = GoogleMapsFunctions();

  @override
  void onInit() async {
    await _googleMapsFunctions.getLocation();
    super.onInit();
  }

  RxBool isFilled() {
    if (emailLoginController.value.text.isNotEmpty &&
        passwordLoginController.value.text.isNotEmpty &&
        isPasswordCorrect.value) {
      return true.obs;
    }
    return false.obs;
  }

  void onSubmitted() async {
    try {
      Indicator.showLoading();
      await _authentication.login(
          emailLoginController.value.text, passwordLoginController.value.text);
    } catch (e) {
      Indicator.closeLoading();
      if (kDebugMode) {
        print(e);
        print(e.toString());
      }
    }
  }
}
