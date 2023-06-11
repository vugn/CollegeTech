// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:teknisi_app/app/data/constants.dart';
import 'package:teknisi_app/app/domain/entities/universities/university_entity.dart';
import 'package:teknisi_app/app/widgets/indicator.dart';

import '../../../../data/repositories/firebase/firebase_auth.dart';
import '../../../../data/repositories/firebase/firebase_functions.dart';

class RegisterController extends GetxController {
  final Rx<TextEditingController> fullNameRegisterController =
      TextEditingController().obs;
  final Rx<TextEditingController> emailRegisterController =
      TextEditingController().obs;
  final Rx<TextEditingController> phoneNumberRegisterController =
      TextEditingController().obs;
  final Rx<TextEditingController> birthRegisterController =
      TextEditingController().obs;
  final Rx<TextEditingController> certificateUploadRegisterController =
      TextEditingController().obs;
  final Rx<TextEditingController> skillDescriptionRegisterController =
      TextEditingController().obs;
  final SingleValueDropDownController universityDropdownRegisterController =
      SingleValueDropDownController();
  final Rx<TextEditingController> ktmUploadRegisterController =
      TextEditingController().obs;
  final Rx<TextEditingController> addressRegisterController =
      TextEditingController().obs;
  final Rx<TextEditingController> profileUploadRegisterController =
      TextEditingController().obs;
  final Rx<TextEditingController> passwordRegisterController =
      TextEditingController().obs;
  final Rx<TextEditingController> confirmPasswordRegisterController =
      TextEditingController().obs;

  RxBool isUserActive = true.obs;
  RxBool isTechnicianActive = false.obs;

// Auth Validate
  RxBool isPasswordMatch = false.obs;
  RxBool isEmailCorrect = false.obs;
  RxBool isPhoneNumberCorrect = false.obs;
  RxBool isPasswordCorrect = false.obs;
  RxList<UniversityEntity> universityList = <UniversityEntity>[].obs;

  Rx<XFile>? profileImage = XFile('').obs;
  RxList<File> ktmsImage = <File>[].obs;
  RxList<File> certificiates = <File>[].obs;

  final FirebaseAuthentication _authentication = FirebaseAuthentication();
  final FirebaseFunctions _functions = FirebaseFunctions();

  @override
  void onInit() async {
    universityList.value = await _functions.getUniversities();
    super.onInit();
  }

  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1995),
        lastDate: DateTime(2030));
    if (pickedDate == null) {
      return;
    }
    birthRegisterController.value.text = parseDateTime(pickedDate.toString());
  }

  String parseDateTime(String inputDate) {
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(inputDate);
    String formattedDate = DateFormat('dd - MM - yyyy').format(dateTime);
    return formattedDate;
  }

  void imagePicker(TextEditingController contoller) async {
    XFile? result = await ImagePicker().pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    if (result != null) {
      profileImage?.value = result;
      contoller.text = formatFileList(isList: false, pathString: result.path);
      update();
    } else {}
  }

  void filePicker(TextEditingController contoller, bool isCertificate) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path ?? '')).toList();
      isCertificate ? certificiates.value = files : ktmsImage.value = files;
      contoller.text = formatFileList(isList: true, pathsList: files);
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

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Get.back();
      },
    );
    Widget deleteButton = TextButton(
      child: const Text(
        "Hapus Gambar",
        style: TextStyle(color: Colors.redAccent),
      ),
      onPressed: () async {
        await File(profileImage!.value.path).delete();
        profileImage = null;
        profileUploadRegisterController.value.clear();
        Get.back();
        update();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Foto Profil mu"),
      content: Image.file(File(profileImage!.value.path)),
      actions: [okButton, deleteButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  RxBool isFilled() {
    if (fullNameRegisterController.value.text.isNotEmpty &&
        emailRegisterController.value.text.isNotEmpty &&
        phoneNumberRegisterController.value.text.isNotEmpty &&
        birthRegisterController.value.text.isNotEmpty &&
        certificateUploadRegisterController.value.text.isNotEmpty &&
        skillDescriptionRegisterController.value.text.isNotEmpty &&
        universityDropdownRegisterController.dropDownValue!.name.isNotEmpty &&
        ktmUploadRegisterController.value.text.isNotEmpty &&
        passwordRegisterController.value.text.isNotEmpty &&
        confirmPasswordRegisterController.value.text.isNotEmpty &&
        profileUploadRegisterController.value.text.isNotEmpty) {
      return true.obs;
    } else {
      return false.obs;
    }
  }

  RxBool isUserFilled() {
    if (fullNameRegisterController.value.text.isNotEmpty &&
        emailRegisterController.value.text.isNotEmpty &&
        phoneNumberRegisterController.value.text.isNotEmpty &&
        passwordRegisterController.value.text.isNotEmpty &&
        confirmPasswordRegisterController.value.text.isNotEmpty &&
        isPasswordMatch.value &&
        isEmailCorrect.value) {
      return true.obs;
    } else {
      return false.obs;
    }
  }

  void onSumbitted({required bool isTechnician}) async {
    if (isTechnician && isFilled().value) {
      Indicator.showLoading();
      try {
        bool emailRegistered = await _functions.getEmailDuplicate(
            email: emailRegisterController.value.text);
        bool phoneRegistered = await _functions.getPhoneNumberDuplicate(
            phoneNumber: phoneNumberRegisterController.value.text);
        if (!emailRegistered) {
          if (!phoneRegistered) {
            await _authentication.createAccount(
                email: emailRegisterController.value.text,
                password: passwordRegisterController.value.text);
            await _functions.createTechnicianUserCredential(
                fullName: fullNameRegisterController.value.text,
                accountType: 1,
                phoneNumber: phoneNumberRegisterController.value.text,
                birth: birthRegisterController.value.text,
                certificates: certificiates,
                fileCertificateExt: path.basename(certificiates[0].path),
                ktms: ktmsImage,
                address: addressRegisterController.value.text,
                skillDescription: skillDescriptionRegisterController.value.text,
                university:
                    universityDropdownRegisterController.dropDownValue?.value,
                profilePhoto: File(profileImage?.value.path ?? ''),
                email: emailRegisterController.value.text,
                password: passwordRegisterController.value.text,
                confirmPassword: confirmPasswordRegisterController.value.text);
          } else {
            Indicator.closeLoading();
            showAlert('Nomor Telepon sudah di gunakan');
          }
        } else {
          Indicator.closeLoading();
          showAlert('Email sudah di gunakan');
        }
      } catch (e) {
        Indicator.closeLoading();
        if (kDebugMode) {
          print(e);
        }
      }
    } else if (isTechnician == false && isUserFilled().value) {
      Indicator.showLoading();
      try {
        bool emailRegistered = await _functions.getEmailDuplicate(
            email: emailRegisterController.value.text);
        bool phoneRegistered = await _functions.getPhoneNumberDuplicate(
            phoneNumber: phoneNumberRegisterController.value.text);

        if (!emailRegistered) {
          if (!phoneRegistered) {
            await _authentication.createAccount(
                email: emailRegisterController.value.text,
                password: passwordRegisterController.value.text);
            await _functions.createUserCredential(
                fullName: fullNameRegisterController.value.text,
                phoneNumber: phoneNumberRegisterController.value.text,
                accountType: 0,
                email: emailRegisterController.value.text,
                password: passwordRegisterController.value.text);
          } else {
            Indicator.closeLoading();
            showAlert('Nomor Telepon sudah di gunakan');
          }
        } else {
          Indicator.closeLoading();
          showAlert('Email sudah di gunakan');
        }
      } catch (e) {
        Indicator.closeLoading();
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
}
