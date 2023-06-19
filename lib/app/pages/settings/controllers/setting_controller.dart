import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_auth.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_snapshots.dart';

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
}
