import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/app/pages/order/controllers/order_controller.dart';
import 'package:teknisi_app/app/utils/color_palette.dart';

class DetailOrderView extends GetView<OrderController> {
  DetailOrderView({super.key});

  final orderData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final userData = orderData['to_user'];
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 28),
            width: double.maxFinite,
            decoration: const BoxDecoration(
                color: cotech,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: userData['profilePhoto'],
                              width: 50,
                            )),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userData['fullName'],
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600))),
                            SizedBox(
                              width: 142,
                              child: Text(orderData['desc_error'],
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ))),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 26,
                          child: FilledButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.all(6)),
                                fixedSize: const MaterialStatePropertyAll(
                                    Size(81, 26)),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.green.shade700)),
                            child: Text("Atur Jadwal",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ))),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 26,
                          child: FilledButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.all(6)),
                                fixedSize: const MaterialStatePropertyAll(
                                    Size(81, 26)),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                backgroundColor: const MaterialStatePropertyAll(
                                    Colors.redAccent)),
                            child: Text("Tolak",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ))),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
