import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/app/pages/order/controllers/order_controller.dart';
import 'package:teknisi_app/app/utils/color_palette.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

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
                            onPressed: () {
                              controller.showOrderDetail(orderData);
                            },
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
          ),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 24,
                      ),
                      BubbleSpecialThree(
                        text: 'bubble special three without tail',
                        color: Color(0xFF1B97F3),
                        tail: false,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      BubbleSpecialThree(
                        text: 'bubble special three with tail',
                        color: Color(0xFF1B97F3),
                        tail: true,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      BubbleSpecialThree(
                        text: "bubble special three without tail",
                        color: Color(0xFFE8E8EE),
                        tail: false,
                        isSender: false,
                      ),
                      BubbleSpecialThree(
                        text: "bubble special three with tail",
                        color: Color(0xFFE8E8EE),
                        tail: true,
                        isSender: false,
                      ),
                      BubbleSpecialThree(
                        text: 'bubble special three without tail',
                        color: Color(0xFF1B97F3),
                        tail: false,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      BubbleSpecialThree(
                        text: 'bubble special three with tail',
                        color: Color(0xFF1B97F3),
                        tail: true,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      BubbleSpecialThree(
                        text: "bubble special three without tail",
                        color: Color(0xFFE8E8EE),
                        tail: false,
                        isSender: false,
                      ),
                      BubbleSpecialThree(
                        text: "bubble special three with tail",
                        color: Color(0xFFE8E8EE),
                        tail: true,
                        isSender: false,
                      ),
                      BubbleSpecialThree(
                        text: 'bubble special three with tail',
                        color: Color(0xFF1B97F3),
                        tail: true,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      BubbleSpecialThree(
                        text: "bubble special three without tail",
                        color: Color(0xFFE8E8EE),
                        tail: false,
                        isSender: false,
                      ),
                      BubbleSpecialThree(
                        text: "bubble special three with tail",
                        color: Color(0xFFE8E8EE),
                        tail: true,
                        isSender: false,
                      ),
                      BubbleSpecialThree(
                        text: 'bubble special three with tail',
                        color: Color(0xFF1B97F3),
                        tail: true,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      BubbleSpecialThree(
                        text: "bubble special three without tail",
                        color: Color(0xFFE8E8EE),
                        tail: false,
                        isSender: false,
                      ),
                      BubbleSpecialThree(
                        text: "bubble special three with tail",
                        color: Color(0xFFE8E8EE),
                        tail: true,
                        isSender: false,
                      ),
                      BubbleSpecialThree(
                        text: 'bubble special three with tail',
                        color: Color(0xFF1B97F3),
                        tail: true,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      BubbleSpecialThree(
                        text: "bubble special three without tail",
                        color: Color(0xFFE8E8EE),
                        tail: false,
                        isSender: false,
                      ),
                      BubbleSpecialThree(
                        text: "bubble special three with tail",
                        color: Color(0xFFE8E8EE),
                        tail: true,
                        isSender: false,
                      ),
                      BubbleSpecialThree(
                        text: 'bubble special three with tail',
                        color: Color(0xFF1B97F3),
                        tail: true,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      BubbleSpecialThree(
                        text: "bubble special three without tail",
                        color: Color(0xFFE8E8EE),
                        tail: false,
                        isSender: false,
                      ),
                      BubbleSpecialThree(
                        text: "bubble special three with tail",
                        color: Color(0xFFE8E8EE),
                        tail: true,
                        isSender: false,
                      ),
                      SizedBox(
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
