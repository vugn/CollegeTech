import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/app/pages/order/controllers/detail_crash_controller.dart';
import 'package:teknisi_app/app/widgets/account_button.dart';
import 'package:teknisi_app/app/widgets/forms.dart';

class DetailCrashView extends GetView<DetailCrashController> {
  const DetailCrashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(CupertinoIcons.back)),
                  Center(
                    child: Image.asset(
                      'assets/images/wind.png',
                      width: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Brand Elektronik",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            fontSize: 12,
                          )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hint: 'Contoh: Panasonic',
                          controller: controller.brandName.value,
                          type: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          onChange: (v) {
                            controller.brandNameText.value = v;
                          },
                          errorText: controller.brandNameText.value.isNotEmpty
                              ? null
                              : 'Harap isi Brand Elektronik',
                          readOnly: controller.brandResult['brandData'] != null
                              ? true
                              : false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Deskripsi Kerusakan",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            fontSize: 12,
                          )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 116,
                          child: CustomTextField(
                            hint: 'Contoh: Tombol power tidak bisa ditekan',
                            controller: controller.crashDesc.value,
                            expands: true,
                            maxLines: null,
                            onChange: (v) {
                              controller.crashDescText.value = v;
                            },
                            errorText: controller.crashDescText.value.isNotEmpty
                                ? null
                                : 'Harap isi Deskripsi Kerusakan',
                            type: TextInputType.multiline,
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Center(
                          child: AccountButton(
                              label: 'Cari Teknisi',
                              isActive: controller.isFilled().value,
                              onTap: () {
                                controller.findTechnician();
                              }),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
