import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_snapshots.dart';
import 'package:teknisi_app/app/data/repositories/firebase/orders/orders_functions.dart';
import 'package:teknisi_app/app/domain/entities/brands/brand_entity.dart';

class TechniciansController extends GetxController {
  final FirebaseOrdersFunctions firebaseOrdersFunctions =
      FirebaseOrdersFunctions();
  final FirebaseSnapshots firebaseSnapshots = FirebaseSnapshots();
  final BrandEntity brandResult = Get.arguments;
}
