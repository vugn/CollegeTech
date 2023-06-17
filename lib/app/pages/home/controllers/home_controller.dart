// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/data/constants.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_auth.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_functions.dart';
import 'package:path/path.dart' as path;
import 'package:teknisi_app/app/data/repositories/firebase/firebase_snapshots.dart';
import 'package:teknisi_app/app/widgets/forms.dart';
import 'package:teknisi_app/app/widgets/indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final FirebaseAuthentication _authentication = FirebaseAuthentication();
  final FirebaseFunctions firebaseFunctions = FirebaseFunctions();
  final FirebaseSnapshots _firebaseSnapshots = FirebaseSnapshots();

  Rx<MultiValueDropDownController> addSkillsDropdownController =
      MultiValueDropDownController().obs;

  // Carousel
  final Rx<CarouselController> carouselController = CarouselController().obs;
  RxInt carouselCurrent = 0.obs;

  User? currentUser;
  RxInt currentIndex = 0.obs;
  late List<String> skillsList;

  RxList<File> certificates = <File>[].obs;
  RxString certificateName = ''.obs;

  late Stream<DocumentSnapshot> userCredentialSnaphot =
      _firebaseSnapshots.getUserCredentialSnapshot();

  @override
  void onInit() async {
    currentUser = _authentication.currentUser();
    skillsList = await firebaseFunctions.getSkills();
    print(skillsList);
    super.onInit();
  }

  // void startStream() {
  //   userCredentialSnaphot.listen((event) {

  //   });
  // }

  void navbarTap(int int) {
    currentIndex.value = int;
  }

  void filePicker() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path ?? '')).toList();
      certificateName.value = formatFileList(isList: true, pathsList: files);
      certificates.value = files;
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

  void showAddCertificateDialog(BuildContext context) {
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
        if (certificates.isNotEmpty) {
          Indicator.showLoading();
          List<Future<String>> certificatesUploaded = certificates
              .map((certificate) async =>
                  await firebaseFunctions.uploadCertificatesTechnician(
                      file: certificate,
                      uid: currentUser!.uid,
                      fileExt: path.basename(certificate.path)))
              .toList();
          Future<List<String>> result = Future.wait(certificatesUploaded);
          await firebaseFunctions.updateCertificatesTechnician(
              currentUser!.uid, await result);
          certificates.clear();
          certificateName.value = '';
          Indicator.closeLoading();
        }

        Get.back();
      },
    );
    Widget deleteButton = TextButton(
      child: const Text(
        "Hapus",
        style: TextStyle(color: Colors.redAccent),
      ),
      onPressed: () async {
        certificateName.value = '';
        certificates.clear();
        Get.back();
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
      title: const Text("Tambah Sertifikat"),
      content: Obx(() => Text(certificateName.value)),
      actions: [addButton, okButton, deleteButton, cancelButton],
    );

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showAddSkillseDialog(BuildContext context) {
    update();
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () async {
        if (addSkillsDropdownController.value.dropDownValueList != null) {
          Indicator.showLoading();
          await firebaseFunctions.updateSkillsTechnician(
              currentUser!.uid,
              addSkillsDropdownController.value.dropDownValueList!
                  .map((e) => e.name)
                  .toList());
          addSkillsDropdownController.value.dropDownValueList!.clear();
          Indicator.closeLoading();
        }
        Get.back();
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
      title: const Text("Tambah Skill"),
      content: Obx(() => CustomTextField(
            dropdownController: addSkillsDropdownController.value,
            hint: 'Skills',
            isDropdown: true,
            isMultiDropdown: true,
            dropdownList: skillsList
                .map((skill) => DropDownValueModel(
                    name: skill,
                    value: skill.toLowerCase().replaceAll(' ', '')))
                .toList(),
          )),
      actions: [okButton, cancelButton],
    );

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showDeleteCertificateDialog(BuildContext context, String url) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () async {
        Indicator.showLoading();
        await firebaseFunctions.deleteCertificatesTechnician(
            currentUser!.uid, url);
        Indicator.closeLoading();
        Get.back();
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
      title: const Text("Hapus Sertifikat"),
      content: Text(
          "Apakah kamu yakin untuk menghapus Sertifikat ${getFileName(url, false)}?"),
      actions: [okButton, cancelButton],
    );

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showDeleteSkillDialog(BuildContext context, String skill) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () async {
        Indicator.showLoading();
        await firebaseFunctions.deleteSkillTechnician(currentUser!.uid, skill);
        Indicator.closeLoading();
        Get.back();
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
      title: const Text("Hapus Skill"),
      content: Text("Apakah kamu yakin untuk menghapus Skill $skill?"),
      actions: [okButton, cancelButton],
    );

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> openCertificate(String url) async {
    Uri data = Uri.parse(url);
    if (!await launchUrl(
      data,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
