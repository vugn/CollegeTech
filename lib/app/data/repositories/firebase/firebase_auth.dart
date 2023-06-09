import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/routes/app_pages.dart';
import 'package:teknisi_app/app/widgets/indicator.dart';

class FirebaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get instance => null;

  Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      Indicator.closeLoading();
      print(e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut().whenComplete(() {
        Get.toNamed(Routes.LOGIN);
      });
      // await _auth.signOut().then((value) {
      //   Get.toNamed(Routes.AUTHENTICATION);
      // });
    } catch (e) {
      print(e.toString());
    }
  }

  User? currentUser() {
    try {
      var user = _auth.currentUser;
      return user;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
