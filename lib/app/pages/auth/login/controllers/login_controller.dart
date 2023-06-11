
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/firebase/firebase_auth.dart';
import '../../../../data/repositories/google_maps/maps_functions.dart';

class LoginController extends GetxController {
  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();
  RxBool isUserActive = true.obs;
  RxBool isTechnicianActive = false.obs;

  final FirebaseAuthentication _authentication = FirebaseAuthentication();
  final GoogleMapsFunctions _googleMapsFunctions = GoogleMapsFunctions();

  @override
  void onInit() async {
     await _googleMapsFunctions.getLocation();
    _authentication.currentUser();
    super.onInit();
  }
}
