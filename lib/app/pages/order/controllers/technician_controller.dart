import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:teknisi_app/app/data/constants.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_auth.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_functions.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_snapshots.dart';
import 'package:teknisi_app/app/data/repositories/firebase/orders/orders_functions.dart';
import 'package:teknisi_app/app/data/repositories/google_maps/maps_functions.dart';
import 'package:teknisi_app/app/pages/main/controllers/main_page_controller.dart';
import 'package:teknisi_app/app/routes/app_pages.dart';
import 'package:teknisi_app/app/widgets/account_button.dart';
import 'package:teknisi_app/app/widgets/indicator.dart';

class TechniciansController extends GetxController {
  MainPageController _mainPageController = Get.find<MainPageController>();
  final FirebaseOrdersFunctions firebaseOrdersFunctions =
      FirebaseOrdersFunctions();
  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions();
  final FirebaseSnapshots firebaseSnapshots = FirebaseSnapshots();
  final FirebaseAuthentication _authentication = FirebaseAuthentication();
  final dynamic technicianResult = Get.arguments;
  late dynamic technicianData;
  late dynamic brandName;
  late dynamic errorDesc;
  late dynamic skillName;

// Maps
  final GoogleMapsFunctions _googleMapsFunctions = GoogleMapsFunctions();
  late LatLng userPosition;
  late LocationData? _locationData;

  @override
  void onInit() {
    super.onInit();
    technicianData = technicianResult['technicianData'];
    brandName = technicianResult['brandName'];
    errorDesc = technicianResult['errorDesc'];
    skillName = technicianResult['skillName'];
  }

  void showNotFoundAddressDialog() async {
    Widget okButton = SizedBox(
        height: 32,
        child: AccountButton(
            label: 'Isi Alamat',
            isActive: true,
            onTap: () {
              Get.toNamed(Routes.ADDRESS);
            }));

    Widget alert = AlertDialog(
      title: const Text("Kamu belum isi alamat"),
      content:
          const Text("Eits... Sebelum membuat pesanan Isi dulu alamat kamu "),
      actions: [okButton],
    );

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void createOrder(int index) async {
    Indicator.showLoading();
    try {
      QuerySnapshot<Object?>? userRequest = await _firebaseFunctions
          .getUserCredential(_authentication.currentUser()!.email!);
      Map userData = userRequest!.docs[0].data() as Map;
      var userAddress = userData['address'];
      if (userAddress != null) {
        String orderRequest = await firebaseOrdersFunctions.createOrder(
            userId: _authentication.currentUser()!.uid,
            technicianId: technicianData[index].data()['uid'],
            address: userAddress,
            brand: brandName,
            dateStart: '',
            descError: errorDesc,
            latlng: userData['latlng'],
            status: 0,
            timeStart: '',
            title: '$skillName Rusak',
            toTechnician: technicianData[index].data(),
            userEmail: _authentication.currentUser()!.email!);
        Indicator.closeLoading();
        showAlert('Sukses menghubungi Teknisi');
        var orderResult =
            await firebaseOrdersFunctions.getUserOder(orderRequest);
        Get.back();
        Get.back();
        Get.back();
        _mainPageController.currentIndex.value = 1;
        _mainPageController.pageController.value.jumpToPage(1);
        Get.toNamed(Routes.DETAILORDER, arguments: orderResult);
        // showModalBottomSheet(
        //   context: Get.context!,
        //   builder: (context) {
        //     return Container(
        //       margin: const EdgeInsets.all(24),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             "Brand Elektronik",
        //             style: GoogleFonts.poppins(
        //                 textStyle: const TextStyle(
        //               fontSize: 12,
        //             )),
        //           ),

        //         ],
        //       ),
        //     );
        //   },
        // );
      } else {
        showNotFoundAddressDialog();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Indicator.closeLoading();
    }
    Indicator.closeLoading();
  }
}
