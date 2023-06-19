import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_auth.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_snapshots.dart';
import 'package:teknisi_app/app/routes/app_pages.dart';
import 'package:teknisi_app/app/widgets/indicator.dart';

class SettingController extends GetxController {
  final FirebaseSnapshots _firebaseSnapshots = FirebaseSnapshots();
  final FirebaseAuthentication _authentication = FirebaseAuthentication();
  User? currentUser;

  late Stream<DocumentSnapshot> userCredentialSnaphot =
      _firebaseSnapshots.getUserCredentialSnapshot();
  @override
  void onInit() async {
    currentUser = _authentication.currentUser();

    super.onInit();
  }

  void showLogOut() {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () async {
        Indicator.showLoading();
        _authentication.logOut();
        Get.offAllNamed(Routes.LOGIN);
        Indicator.closeLoading();
      },
    );
    Widget cancelButton = TextButton(
      child: const Text(
        "Batal",
        style: TextStyle(color: Colors.redAccent),
      ),
      onPressed: () async {
        Get.back();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Keluar Akun"),
      content: const Text("Apakah kamu yakin ingin keluar dari akun ini?"),
      actions: [okButton, cancelButton],
    );

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
