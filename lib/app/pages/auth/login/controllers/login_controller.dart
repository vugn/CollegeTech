import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/data/constants.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_functions.dart';
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
  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions();
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
      bool isTechnicianAccount = await _firebaseFunctions.getUserTypeExist(
          email: emailLoginController.value.text, accountType: 1);
      bool isUserAccount = await _firebaseFunctions.getUserTypeExist(
          email: emailLoginController.value.text, accountType: 0);
      if (isTechnicianActive.value) {
        if (isTechnicianAccount) {
          await _authentication.login(
              email: emailLoginController.value.text,
              password: passwordLoginController.value.text);
        } else {
          Indicator.closeLoading();
          showAlert('Akun tidak ditemukan');
          return;
        }
      } else if (isUserAccount) {
        await _authentication.login(
            email: emailLoginController.value.text,
            password: passwordLoginController.value.text);
      } else {
        Indicator.closeLoading();
        showAlert('Akun tidak ditemukan');
        return;
      }
    } catch (e) {
      Indicator.closeLoading();
      if (kDebugMode) {
        print(e);
        print(e.toString());
      }
    }
  }
}
