import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_auth.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_snapshots.dart';
import 'package:teknisi_app/app/data/repositories/firebase/orders/orders_functions.dart';
import 'package:teknisi_app/app/domain/entities/brands/brand_entity.dart';
import 'package:teknisi_app/app/widgets/indicator.dart';

class TechniciansController extends GetxController {
  final FirebaseOrdersFunctions firebaseOrdersFunctions =
      FirebaseOrdersFunctions();
  final FirebaseSnapshots firebaseSnapshots = FirebaseSnapshots();
  final FirebaseAuthentication _authentication = FirebaseAuthentication();
  final dynamic technicianData = Get.arguments;

  void createOrder() async {
    Indicator.showLoading();
    firebaseOrdersFunctions.createOrder(
        userId: _authentication.currentUser()!.uid,
        technicianId: technicianData[0].data()['uid'],
        address: 'jalan ini itu',
        brand: 'LG',
        dateStart: '19 - 06 - 2023',
        descError: 'Jadi gini, rusaknya tuh karena gatau',
        latlang: '-7.6311, 111.5300',
        status: 0,
        timeStart: '16:00',
        title: 'TES RUSAK 1',
        userEmail: _authentication.currentUser()!.email!,
        toTechnician: technicianData[0].data());
    Indicator.closeLoading();
  }
}
