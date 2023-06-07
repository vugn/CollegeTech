import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/app/pages/auth/register/controllers/register_controller.dart';
import 'package:teknisi_app/app/utils/color_palette.dart';
import 'package:teknisi_app/app/widgets/account_button.dart';
import 'package:teknisi_app/app/widgets/forms.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Align(
                alignment: Alignment.topLeft,
                child: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back_ios,
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: 312,
              child: Center(
                child: Text(
                  "Pilih Tipe Pendaftaran Akun !",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                    color: cotech,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Obx(
              () => Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AccountButton(
                      imageButton: true,
                      imageAssets: "assets/images/icons/user_ic.png",
                      label: 'Umum',
                      isActive: controller.isUserActive.value,
                      onTap: () {
                        controller.isUserActive.value = true;
                        controller.isTechnicianActive.value = false;
                      },
                    ),
                    AccountButton(
                      imageButton: true,
                      imageAssets: "assets/images/icons/worker_ic.png",
                      label: 'Teknisi',
                      isActive: controller.isTechnicianActive.value,
                      onTap: () {
                        controller.isUserActive.value = false;
                        controller.isTechnicianActive.value = true;
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Obx(
              () => SizedBox(
                width: 224,
                child: Center(
                  child: Text(
                    "Hai ${controller.isTechnicianActive.value ? 'Calon Teknisi' : 'Kamu'} ! \nSilahkan isi Formulir di bawah",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      color: Color(cotechSecondaryValue),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  CustomTextField(
                    controller: controller.fullNameRegisterController,
                    hint: 'Nama Lengkap',
                    type: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: controller.phoneNumberRegisterController,
                    hint: 'Nomor Telepon',
                    type: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: controller.birthRegisterController,
                    hint: 'Tanggal Lahir',
                    icon: Icon(
                      Icons.calendar_month,
                      color: controller
                              .birthRegisterController.value.text.isNotEmpty
                          ? cotech
                          : const Color(cotechSecondaryValue),
                    ),
                    readOnly: true,
                    type: TextInputType.datetime,
                    onTap: () async {
                      controller.pickDate(context);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: controller.certificateUploadRegisterController,
                    hint: 'Upload Sertifikat',
                    icon: Icon(
                      Icons.upload_file,
                      color: controller.certificateUploadRegisterController
                              .value.text.isNotEmpty
                          ? cotech
                          : const Color(cotechSecondaryValue),
                    ),
                    readOnly: true,
                    type: TextInputType.text,
                    onTap: () async {
                      controller.filePicker(
                          controller.certificateUploadRegisterController);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 97,
                    child: CustomTextField(
                      controller: controller.skillDescriptionRegisterController,
                      hint: 'Deskripsi Skill',
                      expands: true,
                      maxLines: null,
                      type: TextInputType.multiline,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    dropdownController:
                        controller.universityDropdownRegisterController,
                    hint: 'Pilih Universitas',
                    isDropdown: true,
                    dropdownList: const [
                      DropDownValueModel(
                          name:
                              'Universitas Islam Kalimantan Muhammad Arsyad Al Banjari',
                          value: 'uniskamab'),
                      DropDownValueModel(
                          name: 'Universitas Lambung Mangkurat', value: 'ulm'),
                      DropDownValueModel(
                          name: 'Universitas Islam Negeri Antasari',
                          value: 'uinantasari'),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: controller.ktmUploadRegisterController,
                    hint: 'Upload KTM',
                    icon: Icon(
                      Icons.upload_file,
                      color: controller
                              .ktmUploadRegisterController.value.text.isNotEmpty
                          ? cotech
                          : const Color(cotechSecondaryValue),
                    ),
                    readOnly: true,
                    type: TextInputType.text,
                    onTap: () async {
                      controller
                          .filePicker(controller.ktmUploadRegisterController);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: controller.profileUploadRegisterController,
                    hint: 'Ambil Foto Profile',
                    icon: Icon(
                      Icons.upload_file,
                      color: controller.profileUploadRegisterController.value
                              .text.isNotEmpty
                          ? cotech
                          : const Color(cotechSecondaryValue),
                    ),
                    readOnly: true,
                    type: TextInputType.text,
                    onTap: () async {
                      if (controller
                          .profileUploadRegisterController.value.text.isEmpty) {
                        controller.imagePicker(
                            controller.profileUploadRegisterController);
                      } else {
                        controller.showAlertDialog(context);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: controller.emailRegisterController,
                    hint: 'e-Mail',
                    type: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: controller.passwordRegisterController,
                    hint: 'Password',
                    isPassword: true,
                    maxLines: 1,
                    type: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: controller.confirmPasswordRegisterController,
                    hint: 'Konfirmasi Password',
                    isPassword: true,
                    maxLines: 1,
                    type: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Obx(() => AccountButton(
                      label: 'Daftar',
                      size: Size(MediaQuery.of(context).size.width, 48),
                      isActive: controller.isFilled().value,
                      onTap: () {
                        controller.onSumbitted();
                      })),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      )),
    );
  }
}
