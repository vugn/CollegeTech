import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/app/pages/order/controllers/order_controller.dart';
import 'package:teknisi_app/app/utils/color_palette.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: Column(
                        children: <Widget>[
                          Column(children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: 52,
                              margin: const EdgeInsets.all(16),
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                child: Obx(() => TabBar(
                                      onTap: (value) => controller
                                          .currentTabIndex.value = value,
                                      controller:
                                          controller.tabBarController.value,
                                      indicator: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      labelColor: Colors.white,
                                      labelStyle: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12)),
                                      unselectedLabelColor:
                                          const Color(0xFF494949),
                                      unselectedLabelStyle: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12)),
                                      overlayColor:
                                          const MaterialStatePropertyAll(
                                              Colors.transparent),
                                      tabs: [
                                        Tab(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: controller
                                                            .currentTabIndex
                                                            .value ==
                                                        0
                                                    ? cotech
                                                    : const Color(0xFFD9D9D9),
                                                boxShadow: [
                                                  controller.tabBarController
                                                              .value.index ==
                                                          0
                                                      ? BoxShadow(
                                                          offset: const Offset(
                                                              0, 2),
                                                          blurRadius: 12,
                                                          color:
                                                              cotech.shade100)
                                                      : const BoxShadow()
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: const Align(
                                              alignment: Alignment.center,
                                              child: Text("Order"),
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: controller
                                                            .currentTabIndex
                                                            .value ==
                                                        1
                                                    ? cotech
                                                    : const Color(0xFFD9D9D9),
                                                boxShadow: [
                                                  controller.tabBarController
                                                              .value.index ==
                                                          1
                                                      ? BoxShadow(
                                                          offset: const Offset(
                                                              0, 2),
                                                          blurRadius: 12,
                                                          color:
                                                              cotech.shade100)
                                                      : const BoxShadow()
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: const Align(
                                              alignment: Alignment.center,
                                              child: Text("Jadwal"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ])
                        ],
                      ),
                    )
                  ],
              body: Container(
                margin: const EdgeInsets.all(24),
                child: Obx(() => TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller.tabBarController.value,
                        children: [
                          Center(
                            child: Text('TAB 1'),
                          ),
                          Center(
                            child: Text('TAB 2'),
                          ),
                        ])),
              ))),
    );
  }
}
