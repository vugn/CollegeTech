import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/app/utils/color_palette.dart';
import 'package:teknisi_app/app/widgets/account_button.dart';
import 'package:teknisi_app/app/widgets/forms.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 85,
            ),
            Center(
              child: Text(
                "Pilih Tipe Akun !",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                  color: cotech,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
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
                    "Hai ${controller.isTechnicianActive.value ? 'Teknisi' : 'Kamu'} ! \nSilahkan isi Formulir di bawah",
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
            Obx(() => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: controller.emailLoginController.value,
                        hint: 'e-Mail',
                        type: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        errorText: controller
                                .emailLoginController.value.text.isNotEmpty
                            ? controller.isEmailCorrect.value
                                ? null
                                : "Email tidak benar"
                            : null,
                        onChange: (value) {
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)
                              ? controller.isEmailCorrect.value = true
                              : controller.isEmailCorrect.value = false;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: controller.passwordLoginController.value,
                        hint: 'Password',
                        isPassword: true,
                        maxLines: 1,
                        type: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        errorText: controller
                                .passwordLoginController.value.text.isNotEmpty
                            ? controller.isPasswordCorrect.value
                                ? null
                                : "Password minimal 6 karakter"
                            : null,
                        onChange: (value) {
                          controller.isPasswordCorrect.value =
                              RegExp("(?=.*[0-9a-zA-Z]).{6,}").hasMatch(value)
                                  ? true
                                  : false;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Lupa Password?',
                              style: TextStyle(color: cotech),
                            )),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      AccountButton(
                          label: 'Masuk',
                          size: Size(MediaQuery.of(context).size.width, 48),
                          isActive: controller.isFilled().value,
                          onTap: () {
                            if (controller.isFilled().value) {
                              controller.onSubmitted();
                            }
                          }),
                    ],
                  ),
                )),
            const SizedBox(
              height: 32,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum Punya Akun?"),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(
                          '/register',
                        );
                      },
                      child: const Text(
                        'Daftar',
                        style: TextStyle(color: cotech),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      )),
    );
  }
}
