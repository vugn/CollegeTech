import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/app/pages/history/controllers/history_controller.dart';
import 'package:teknisi_app/app/routes/app_pages.dart';
import 'package:teknisi_app/app/utils/color_palette.dart';
import 'package:teknisi_app/app/widgets/account_button.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/images/wind.png',
                width: 50,
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    controller.firebaseSnapshots.getOrdersTechnicianSnapshot(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.waiting ||
                      snapshot.connectionState != ConnectionState.none) {
                    if (snapshot.hasData) {
                      List orders = snapshot.data!.docs
                          .where((element) =>
                              element['status'] == 3 || element['status'] == 4)
                          .toList();
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: orders.isNotEmpty ? orders.length : 1,
                        itemBuilder: (context, index) {
                          if (orders.isEmpty) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: const Center(
                                child: Text("Tidak ada Riwayat"),
                              ),
                            );
                          }
                          var orderData = orders[index].data();
                          var userData = orderData['to_user'];
                          var technicianData = orderData['to_technician'];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 13),
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
                                        imageUrl: technicianData != null
                                            ? technicianData['profilePhoto']
                                            : userData['profilePhoto'],
                                        width: 50,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 15,
                                          child: Row(
                                            children: [
                                              Text(
                                                orderData['title'],
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontSize: 10)),
                                              ),
                                              const VerticalDivider(
                                                thickness: 1,
                                                color:
                                                    Color(cotechSecondaryValue),
                                              ),
                                              Text(
                                                orderData['brand'],
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          orderData['status'] == 3
                                              ? "Selesai"
                                              : "Gagal",
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                            color: orderData['status'] == 3
                                                ? Colors.green.shade700
                                                : Colors.redAccent,
                                            fontSize: 10,
                                          )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                AccountButton(
                                    size: const Size(100, 32),
                                    label: 'Cek',
                                    isActive: true,
                                    onTap: () {
                                      Get.toNamed(Routes.DETAILORDER,
                                          arguments: orderData);
                                    })
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
