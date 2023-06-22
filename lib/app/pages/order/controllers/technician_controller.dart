import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
  final dynamic technicianResult = Get.arguments;
  late dynamic technicianData;
  late dynamic brandName;
  late dynamic errorDesc;
  late dynamic skillName;

  @override
  void onInit() {
    super.onInit();
    technicianData = technicianResult['technicianData'];
    brandName = technicianResult['brandName'];
    errorDesc = technicianResult['errorDesc'];
    skillName = technicianResult['skillName'];
  }

  void createOrder(int index) async {
    Indicator.showLoading();
    try {
      firebaseOrdersFunctions.createOrder(
          userId: _authentication.currentUser()!.uid,
          technicianId: technicianData[index].data()['uid'],
          address: 'jalan ini itu',
          brand: brandName,
          dateStart: '19 - 06 - 2023',
          descError: errorDesc,
          latlang: '-7.6311, 111.5300',
          status: 0,
          timeStart: '16:00',
          title: '$skillName RUSAK',
          userEmail: _authentication.currentUser()!.email!,
          toTechnician: technicianData[0].data());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Indicator.closeLoading();
    }
    Indicator.closeLoading();
  }
}
