import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/app/pages/order/controllers/order_controller.dart';
import 'package:teknisi_app/app/utils/color_palette.dart';
import 'package:teknisi_app/app/widgets/account_button.dart';

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
              body: Obx(() => TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.tabBarController.value,
                      children: [
                        FutureBuilder(
                          future: controller.getOrders(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  var orderData = snapshot.data![index].data();
                                  var userData = orderData['to_user'];
                                  bool isWaiting = orderData['status'] == 0;
                                  if (!isWaiting) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      child: const Center(
                                        child: Text("Tidak ada Orderan"),
                                      ),
                                    );
                                  }
                                  return Container(
                                    margin: const EdgeInsets.all(24),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 13),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: const Offset(0, 2),
                                              blurRadius: 12,
                                              color: Colors.black
                                                  .withOpacity(0.25))
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    userData['profilePhoto'],
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
                                                            textStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        10)),
                                                      ),
                                                      const VerticalDivider(
                                                        thickness: 1,
                                                        color: Color(
                                                            cotechSecondaryValue),
                                                      ),
                                                      Text(
                                                        orderData['brand'],
                                                        style: GoogleFonts.poppins(
                                                            textStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  "Menunggu Konfirmasi",
                                                  style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                              color: cotech,
                                                              fontSize: 10)),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        AccountButton(
                                            size: const Size(100, 32),
                                            label: 'Hubungi',
                                            isActive: true,
                                            onTap: () {})
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                        Center(
                          child: Text('TAB 2'),
                        ),
                      ])))),
    );
  }
}
