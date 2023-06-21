import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/app/pages/order/controllers/technician_controller.dart';
import 'package:teknisi_app/app/routes/app_pages.dart';
import 'package:teknisi_app/app/utils/color_palette.dart';
import 'package:teknisi_app/app/widgets/account_button.dart';

class TechniciansView extends GetView<TechniciansController> {
  const TechniciansView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Pilh Teknisi",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.technicianData.length,
              itemBuilder: (context, index) {
                var technicianData = controller.technicianData[index].data();
                List<dynamic> technicianSkills = technicianData['skills'];
                // return SizedBox(
                //   height: MediaQuery.of(context).size.height / 1.5,
                //   child: const Center(
                //     child: Text("Tidak ada Riwayat"),
                //   ),
                // );
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 2),
                            blurRadius: 12,
                            color: Colors.black.withOpacity(0.25))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: technicianData['profilePhoto'],
                              width: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: Text(
                                        technicianData['fullName'],
                                        style: GoogleFonts.poppins(
                                            textStyle:
                                                const TextStyle(fontSize: 10)),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      thickness: 1,
                                      color: Color(cotechSecondaryValue),
                                    ),
                                    Text(
                                      technicianData['rating'].toString(),
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  technicianSkills
                                      .toString()
                                      .replaceAll('[', '')
                                      .replaceAll(']', ''),
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                    color: Colors.green.shade700,
                                    fontSize: 10,
                                  )),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                            child: AccountButton(
                                size: const Size(100, 32),
                                label: 'Hubungi',
                                isActive: true,
                                onTap: () {
                                  controller.createOrder();
                                }),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            height: 20,
                            child: AccountButton(
                                size: const Size(100, 32),
                                label: 'Detail',
                                isActive: false,
                                onTap: () {}),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
