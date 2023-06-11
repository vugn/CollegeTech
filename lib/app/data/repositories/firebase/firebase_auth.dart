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
    } on FirebaseAuthException catch (e) {
      Indicator.closeLoading();
      if (kDebugMode) {
        print(e.code);
      }
      switch (e.code) {
        case 'email-already-in-use':
          showAlert('Email Sudah di gunakan');
          break;
        case 'invalid-email':
          showAlert('Email tidak valid');
          break;
        case 'operation-not-allowed':
          showAlert(e.code);
          break;
        case 'weak-password':
          showAlert('Password lemah');
          break;
      }
    }
  }

  Future<User?> login({required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      Indicator.closeLoading();
      Get.toNamed(Routes.HOME);
      return Future.value(user);
    } on FirebaseAuthException catch (e) {
      Indicator.closeLoading();
      if (kDebugMode) {
        print(e.code);
      }
      switch (e.code) {
        case 'invalid-email':
          showAlert('Email tidak valid');
          break;
        case 'wrong-password':
          showAlert('Password Salah');
          break;
        case 'user-not-found':
          showAlert('Akun tidak di temukan');
          break;
        case 'user-disabled':
          showAlert('Akun dimatikan');
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
