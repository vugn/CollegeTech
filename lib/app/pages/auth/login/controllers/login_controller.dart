import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/firebase/firebase_auth.dart';

class LoginController extends GetxController {
  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();
  RxBool isUserActive = true.obs;
  RxBool isTechnicianActive = false.obs;

  final FirebaseAuthentication _authentication = FirebaseAuthentication();

  @override
  void onInit() {
    User? user = _authentication.currentUser();
    print("DATA USER SEKARANG: ${user}");
    super.onInit();
  }
}
