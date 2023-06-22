import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:teknisi_app/app/pages/address/controllers/address_controller.dart';
import 'package:teknisi_app/app/widgets/account_button.dart';
import 'package:teknisi_app/app/widgets/forms.dart';

class AddressView extends GetView<AddressController> {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          controller.locationSubscription.cancel();
          return true;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
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
                        "Pilih Koordinat",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontSize: 12,
                        )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: double.maxFinite,
                          height: 200,
                          child: Obx(() => GoogleMap(
                              myLocationEnabled: true,
                              onMapCreated: controller.onMapCreated,
                              initialCameraPosition:
                                  controller.cameraPosition.value,
                              markers: controller.markers))),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Deskripsi Alamat",
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
                        child: Obx(() => CustomTextField(
                              hint: 'Contoh: Jl A Yani no 29',
                              controller: controller.addressController.value,
                              expands: true,
                              maxLines: null,
                              onChange: (v) {
                                controller.text.value = v;
                              },
                              errorText: controller.text.isNotEmpty
                                  ? null
                                  : 'Harap isi Deskripsi Alamat',
                              type: TextInputType.multiline,
                            )),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Center(
                        child: Obx(() => AccountButton(
                            label: 'Tambah Alamat',
                            isActive: controller.text.value.isNotEmpty,
                            onTap: () {
                              controller.onSubmit();
                            })),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
