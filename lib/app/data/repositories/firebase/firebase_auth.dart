import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/data/constants.dart';
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
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: email);
      User? user = result.user;
      Indicator.closeLoading();
      return Future.value(user);
    } on FirebaseAuthException catch (e) {
      Indicator.closeLoading();
      if (kDebugMode) {
        print(e.code);
      }
      switch (e.code) {
        case 'invalid-email':
          showAlert(e.code);
          break;
        case 'wrong-password':
          showAlert(e.code);
          break;
        case 'user-not-found':
          showAlert(e.code);
          break;
        case 'user-disabled':
          showAlert(e.code);
          break;
      }
    }
    return null;
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
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  User? currentUser() {
    try {
      var user = _auth.currentUser;
      return user;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
