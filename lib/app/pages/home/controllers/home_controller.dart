import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_auth.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_functions.dart';
import 'package:path/path.dart' as path;

class HomeController extends GetxController {
  final FirebaseAuthentication _authentication = FirebaseAuthentication();
  final FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  // Carousel
  final Rx<CarouselController> carouselController = CarouselController().obs;
  RxInt carouselCurrent = 0.obs;

  User? currentUser;
  RxInt currentIndex = 0.obs;

  RxList<File> certificiates = <File>[].obs;
  RxString certificateName = ''.obs;

  @override
  void onInit() {
    currentUser = _authentication.currentUser();
    super.onInit();
  }

  void navbarTap(int int) {
    currentIndex.value = int;
  }

  void filePicker() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path ?? '')).toList();
      certificateName.value = formatFileList(isList: true, pathsList: files);
      update();
    } else {
      result?.paths.map((path) async => await File(path ?? '').delete());
    }
  }

  String formatFileList(
      {bool? isList, String? pathString, List<File>? pathsList}) {
    if (isList == true) {
      List<String> formattedList = pathsList!.map((item) {
        String fileName = path.basename(item.path);
        return fileName;
      }).toList();

      String formattedString = formattedList.join(', ');
      return formattedString;
    } else {
      return '${path.basename(pathString!)} (Ketuk untuk melihat)';
    }
  }

  showAddCertificateDialog(BuildContext context) {
    update();
    Widget addButton = TextButton(
      child: const Text("Tambah"),
      onPressed: () async {
        filePicker();
      },
    );
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () async {
        certificateName.value = '';
        Get.back();
      },
    );
    Widget deleteButton = TextButton(
      child: const Text(
        "Batal",
        style: TextStyle(color: Colors.redAccent),
      ),
      onPressed: () async {
        Get.back();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Tambah Sertifikat"),
      content: Obx(() => Text(certificateName.value)),
      actions: [addButton, okButton, deleteButton],
    );

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
