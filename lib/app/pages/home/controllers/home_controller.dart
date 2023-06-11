import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_auth.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_functions.dart';

class HomeController extends GetxController {
  final FirebaseAuthentication _authentication = FirebaseAuthentication();
  final FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  User? currentUser;

  @override
  void onInit() {
    currentUser = _authentication.currentUser();
    super.onInit();
  }
}
