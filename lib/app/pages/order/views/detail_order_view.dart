import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/app/pages/order/controllers/order_controller.dart';
import 'package:teknisi_app/app/utils/color_palette.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:swipe_to/swipe_to.dart';

class DetailOrderView extends GetView<OrderController> {
  DetailOrderView({super.key});

  final orderData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final userData = orderData['to_technician'];
    final technicianData = orderData['to_user'];
    bool isTechnician = technicianData != null && userData == null;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
                color: cotech,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      color: Colors.white,
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(CupertinoIcons.back)),
                  Container(
                    padding:
                        const EdgeInsets.only(right: 28, left: 28, bottom: 24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      imageUrl: isTechnician
                                          ? technicianData['profilePhoto']
                                          : userData['profilePhoto'],
                                      width: 50,
                                    )),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        isTechnician
                                            ? technicianData['fullName']
                                            : userData['fullName'],
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
                            isTechnician
                                ? Column(children: [
                                    SizedBox(
                                      height: 26,
                                      child: FilledButton(
                                        onPressed: () {
                                          controller.showOrderDetail(orderData);
                                        },
                                        style: ButtonStyle(
                                            padding:
                                                const MaterialStatePropertyAll(
                                                    EdgeInsets.all(6)),
                                            fixedSize:
                                                const MaterialStatePropertyAll(
                                                    Size(81, 26)),
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
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
                                        onPressed: () {
                                          controller.showOrderDetail(orderData);
                                        },
                                        style: ButtonStyle(
                                            padding:
                                                const MaterialStatePropertyAll(
                                                    EdgeInsets.all(6)),
                                            fixedSize:
                                                const MaterialStatePropertyAll(
                                                    Size(81, 26)),
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                                    Colors.redAccent)),
                                        child: Text("Tolak",
                                            style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ))),
                                      ),
                                    ),
                                  ])
                                : SizedBox(
                                    height: 26,
                                    child: FilledButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                          padding:
                                              const MaterialStatePropertyAll(
                                                  EdgeInsets.all(6)),
                                          fixedSize:
                                              const MaterialStatePropertyAll(
                                                  Size(81, 26)),
                                          shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.redAccent)),
                                      child: Text("Lapor",
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ))),
                                    ),
                                  )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.8,
                      ),
                      SwipeTo(
                        iconColor: cotech,
                        child: const BubbleSpecialThree(
                          text: 'Halo ada TV nya kenapa ya?',
                          color: Color(0xFFE8E8EE),
                          tail: true,
                          isSender: false,
                        ),
                        onRightSwipe: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SwipeTo(
                        iconColor: cotech,
                        child: const BubbleSpecialThree(
                          text: "TV Saya tidak mau nyala",
                          color: cotech,
                          tail: true,
                          isSender: true,
                          textStyle: TextStyle(color: Colors.white),
                        ),
                        onRightSwipe: () {},
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
                MessageBar(
                  sendButtonColor: cotech,
                  onSend: (_) {
                    if (kDebugMode) {
                      print(_);
                    }
                  },
                  actions: [
                    InkWell(
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 24,
                      ),
                      onTap: () {},
                    ),
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
