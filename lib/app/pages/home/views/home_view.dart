import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/app/data/constants.dart';
import 'package:teknisi_app/app/domain/entities/brands/brand_entity.dart';
import 'package:teknisi_app/app/pages/home/controllers/home_controller.dart';
import 'package:teknisi_app/app/routes/app_pages.dart';
import 'package:teknisi_app/app/utils/color_palette.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:teknisi_app/app/widgets/account_button.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot?>(
        stream: controller.userCredentialSnaphot,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting ||
              snapshot.connectionState != ConnectionState.none) {
            if (snapshot.hasData) {
              var userData = jsonDecode(jsonEncode(snapshot.data!.data()));
              var accountType = userData['accountType'];
              List<dynamic>? certificateList = userData['certificates'];
              List<dynamic>? skillsList = userData['skills'];
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 2,
                  ),
                  Container(
                    height: 150,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: const BoxDecoration(color: cotech),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl: userData['profilePhoto'],
                                width: 50,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData['fullName'],
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  )),
                                ),
                                accountType == 0
                                    ? const SizedBox()
                                    : Text(
                                        ' ${skillsList!.isNotEmpty ? 'Teknisi ${skillsList[0]}' : 'Belum Memiliki Skill'}',
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.normal,
                                        )),
                                      ),
                              ],
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Stack(
                      children: [
                        Container(
                          transform: Matrix4.translationValues(0.0, 140.0, 0.0),
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              color: Colors.white),
                          child: Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 145,
                                  ),
                                  CarouselSlider(
                                      carouselController:
                                          controller.carouselController.value,
                                      items: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                      ],
                                      options: CarouselOptions(
                                        height: 100,
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 10),
                                        onPageChanged: (index, reason) =>
                                            controller.carouselCurrent.value =
                                                index,
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () => controller
                                            .carouselController.value
                                            .animateToPage(0),
                                        child: Container(
                                          width: 5,
                                          height: 5,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 4.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : cotech)
                                                  .withOpacity(controller
                                                              .carouselCurrent
                                                              .value ==
                                                          0
                                                      ? 0.9
                                                      : 0.4)),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => controller
                                            .carouselController.value
                                            .animateToPage(1),
                                        child: Container(
                                          width: 5,
                                          height: 5,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 4.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : cotech)
                                                  .withOpacity(controller
                                                              .carouselCurrent
                                                              .value ==
                                                          1
                                                      ? 0.9
                                                      : 0.4)),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => controller
                                            .carouselController.value
                                            .animateToPage(2),
                                        child: Container(
                                          width: 5,
                                          height: 5,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 4.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : cotech)
                                                  .withOpacity(controller
                                                              .carouselCurrent
                                                              .value ==
                                                          2
                                                      ? 0.9
                                                      : 0.4)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 41,
                                  ),
                                  accountType == 0
                                      ? Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  "Mau Perbaiki Apa Hari ini ?",
                                                  style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                ),
                                              ),
                                              StreamBuilder<
                                                  DocumentSnapshot<
                                                      Map<String, dynamic>>>(
                                                stream:
                                                    controller.brandsSnapshot,
                                                builder: (context, snapshot) {
                                                  if (snapshot.connectionState !=
                                                          ConnectionState
                                                              .waiting ||
                                                      snapshot.connectionState !=
                                                          ConnectionState
                                                              .none) {
                                                    if (snapshot.hasData) {
                                                      List? data = snapshot
                                                          .data!
                                                          .data()!
                                                          .values
                                                          .toList()[0];
                                                      List? brands = data
                                                              ?.map((e) => e)
                                                              .toList() ??
                                                          [
                                                            const BrandEntity(
                                                                image: '',
                                                                name: '',
                                                                brands: [])
                                                          ];
                                                      List<BrandEntity> result =
                                                          brands
                                                              .map((e) =>
                                                                  BrandEntity
                                                                      .fromJson(
                                                                          e))
                                                              .toList();

                                                      return GridView.count(
                                                        shrinkWrap: true,
                                                        crossAxisCount: 2,
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        childAspectRatio: 1.65,
                                                        children: List.generate(
                                                            result.length,
                                                            (index) =>
                                                                Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .all(6),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        CachedNetworkImage(
                                                                          imageUrl:
                                                                              result[index].image,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        Material(
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.5),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Get.toNamed(Routes.BRANDLIST, arguments: result[index]);
                                                                            },
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                result[index].name,
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )),
                                                      );
                                                    }
                                                  }

                                                  return const CircularProgressIndicator();
                                                },
                                              ),
                                              const SizedBox(
                                                height: 24,
                                              ),
                                              AccountButton(
                                                  label: 'Lihat Selengkapnya',
                                                  isActive: true,
                                                  onTap: () {}),
                                              const SizedBox(
                                                height: 200,
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Sertifikat/Lisensi",
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                              const SizedBox(
                                                height: 14,
                                              ),
                                              Container(
                                                width: double.maxFinite,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    4,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          offset: const Offset(
                                                              0, 2),
                                                          blurRadius: 12,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.25))
                                                    ]),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      color:
                                                          Colors.grey.shade200,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              7,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 14),
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        itemExtent:
                                                            certificateList!
                                                                    .isNotEmpty
                                                                ? 20
                                                                : null,
                                                        itemCount:
                                                            certificateList
                                                                    .isNotEmpty
                                                                ? certificateList
                                                                    .length
                                                                : 1,
                                                        itemBuilder:
                                                            (context, index) {
                                                          if (certificateList
                                                              .isNotEmpty) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      2.3,
                                                                  child: Text(
                                                                    getFileName(
                                                                        certificateList[
                                                                            index],
                                                                        false),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    FilledButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await controller
                                                                              .openCertificate(certificateList[index]);
                                                                        },
                                                                        style:
                                                                            ButtonStyle(
                                                                          minimumSize: const MaterialStatePropertyAll(Size(
                                                                              33,
                                                                              15)),
                                                                          shape:
                                                                              MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
                                                                          padding:
                                                                              const MaterialStatePropertyAll(EdgeInsets.zero),
                                                                        ),
                                                                        child:
                                                                            const Text(
                                                                          'Lihat',
                                                                          style: TextStyle(
                                                                              fontSize: 10,
                                                                              color: Colors.white),
                                                                        )),
                                                                    FilledButton(
                                                                        onPressed:
                                                                            () async {
                                                                          controller.showDeleteCertificateDialog(
                                                                              context,
                                                                              certificateList[index]);
                                                                        },
                                                                        style:
                                                                            ButtonStyle(
                                                                          minimumSize: const MaterialStatePropertyAll(Size(
                                                                              33,
                                                                              15)),
                                                                          backgroundColor:
                                                                              const MaterialStatePropertyAll(Colors.redAccent),
                                                                          shape:
                                                                              MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
                                                                          padding:
                                                                              const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 4)),
                                                                        ),
                                                                        child:
                                                                            const Text(
                                                                          'Hapus',
                                                                          style: TextStyle(
                                                                              fontSize: 10,
                                                                              color: Colors.white),
                                                                        )),
                                                                  ],
                                                                )
                                                              ],
                                                            );
                                                          } else {
                                                            return const Center(
                                                              child: Text(
                                                                "Tidak ada Sertifikat",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 24,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    SizedBox(
                                                      width: 218,
                                                      child: AccountButton(
                                                          label: 'Tambah +',
                                                          isActive: true,
                                                          onTap: () {
                                                            controller
                                                                .showAddCertificateDialog(
                                                                    context);
                                                          }),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 41,
                                  ),
                                  accountType == 0
                                      ? const SizedBox()
                                      : Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Keahlian",
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                              const SizedBox(
                                                height: 14,
                                              ),
                                              Container(
                                                width: double.maxFinite,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    4,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          offset: const Offset(
                                                              0, 2),
                                                          blurRadius: 12,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.25))
                                                    ]),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      color:
                                                          Colors.grey.shade200,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              7,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 14),
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        itemExtent: skillsList!
                                                                .isNotEmpty
                                                            ? 20
                                                            : null,
                                                        itemCount: skillsList
                                                                .isNotEmpty
                                                            ? skillsList.length
                                                            : 1,
                                                        itemBuilder:
                                                            (context, index) {
                                                          if (skillsList
                                                              .isNotEmpty) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      2.3,
                                                                  child: Text(
                                                                    skillsList[
                                                                        index],
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                                FilledButton(
                                                                    onPressed:
                                                                        () {
                                                                      controller.showDeleteSkillDialog(
                                                                          context,
                                                                          skillsList[
                                                                              index]);
                                                                    },
                                                                    style:
                                                                        ButtonStyle(
                                                                      minimumSize:
                                                                          const MaterialStatePropertyAll(Size(
                                                                              33,
                                                                              15)),
                                                                      backgroundColor:
                                                                          const MaterialStatePropertyAll(
                                                                              Colors.redAccent),
                                                                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(2))),
                                                                      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              4)),
                                                                    ),
                                                                    child:
                                                                        const Text(
                                                                      'Hapus',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              Colors.white),
                                                                    ))
                                                              ],
                                                            );
                                                          }

                                                          return const Center(
                                                            child: Text(
                                                              "Tidak ada Skill",
                                                              style: TextStyle(
                                                                fontSize: 24,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    SizedBox(
                                                      width: 218,
                                                      child: AccountButton(
                                                          label: 'Tambah +',
                                                          isActive: true,
                                                          onTap: () async {
                                                            controller
                                                                .showAddSkillseDialog(
                                                                    context);
                                                          }),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 200,
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              )),
                        ),
                        Positioned(
                          top: 115,
                          right: 0,
                          left: 0,
                          child: Container(
                            // transform: Matrix4.translationValues(0, 115.0, 0.0),
                            padding: const EdgeInsets.all(16),
                            height: 153,
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 2),
                                      blurRadius: 12,
                                      color: Colors.black.withOpacity(0.25))
                                ]),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.people_outlined,
                                                color: cotech,
                                                size: 15,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                accountType == 0
                                                    ? 'Pesanan: ${userData['orders']}'
                                                    : 'Pelanggan: ${userData['customers']}',
                                                style: const TextStyle(
                                                    fontSize: 10),
                                              )
                                            ],
                                          ),
                                          accountType == 0
                                              ? const SizedBox()
                                              : Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'Rating Kamu:',
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      '${userData['rating']}/5',
                                                      style: const TextStyle(
                                                          color: cotech,
                                                          fontSize: 10),
                                                    )
                                                  ],
                                                ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            CupertinoIcons.heart,
                                            color: Colors.red,
                                            size: 15,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            accountType == 0
                                                ? 'Lencana Kamu: '
                                                : 'Level Kamu: Sang ',
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                          Text(
                                            accountType == 0
                                                ? '${userData['badge']}'
                                                : '${userData['levelType']}',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: accountType == 0
                                                    ? userData['badge'] ==
                                                            'Gold'
                                                        ? cotech
                                                        : userData['badge'] ==
                                                                'Silver'
                                                            ? Colors.grey
                                                            : userData['badge'] ==
                                                                    'Bronze'
                                                                ? Colors.brown
                                                                : Colors.black
                                                    : Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  accountType == 0
                                      ? StreamBuilder<
                                          QuerySnapshot<Map<String, dynamic>>>(
                                          stream: controller.orderSnapshot,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState !=
                                                    ConnectionState.waiting ||
                                                snapshot.connectionState !=
                                                    ConnectionState.none) {
                                              if (snapshot.hasData) {
                                                var orders = snapshot.data!.docs
                                                    .where((element) =>
                                                        element
                                                            .data()['status'] ==
                                                        0);
                                                if (orders.isNotEmpty) {
                                                  var currentOrder =
                                                      orders.first.data();
                                                  return InkWell(
                                                      onTap: () {
                                                        controller
                                                            .bottomNavbarController
                                                            .currentIndex
                                                            .value = 1;
                                                        controller
                                                            .bottomNavbarController
                                                            .pageController
                                                            .value
                                                            .jumpToPage(1);
                                                      },
                                                      child: Container(
                                                        height: 55,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  offset:
                                                                      const Offset(
                                                                          0, 2),
                                                                  blurRadius:
                                                                      12,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.25))
                                                            ]),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                'Perbaikan ${currentOrder['title']}',
                                                                style: GoogleFonts.poppins(
                                                                    textStyle: const TextStyle(
                                                                        fontSize:
                                                                            8,
                                                                        fontWeight:
                                                                            FontWeight.w600))),
                                                            Text(
                                                                currentOrder[
                                                                    'desc_error'],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: GoogleFonts.poppins(
                                                                    textStyle: const TextStyle(
                                                                        fontSize:
                                                                            8,
                                                                        color:
                                                                            cotech))),
                                                            Row(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    const Icon(
                                                                      CupertinoIcons
                                                                          .clock,
                                                                      size: 8,
                                                                      color:
                                                                          cotech,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                        'Menuggu Perbaikan',
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        style: GoogleFonts.poppins(
                                                                            textStyle:
                                                                                const TextStyle(fontSize: 8, color: cotech)))
                                                                  ],
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ));
                                                }
                                              }
                                            }
                                            return Container(
                                              height: 50,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset:
                                                            const Offset(0, 2),
                                                        blurRadius: 12,
                                                        color: Colors.black
                                                            .withOpacity(0.25))
                                                  ]),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    const Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'TIdak ada pesanan terbaru',
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                    RotatedBox(
                                                        quarterTurns: 1,
                                                        child: Opacity(
                                                          opacity: 0.5,
                                                          child: Image.asset(
                                                            'assets/images/wind.png',
                                                          ),
                                                        )),
                                                  ]),
                                            );
                                          },
                                        )
                                      : IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              StreamBuilder<
                                                      QuerySnapshot<
                                                          Map<String,
                                                              dynamic>>>(
                                                  stream:
                                                      controller.orderSnapshot,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.connectionState !=
                                                            ConnectionState
                                                                .waiting ||
                                                        snapshot.connectionState !=
                                                            ConnectionState
                                                                .none) {
                                                      if (snapshot.hasData) {
                                                        var orders = snapshot
                                                            .data!.docs
                                                            .where((element) =>
                                                                element.data()[
                                                                    'status'] ==
                                                                0);
                                                        if (orders.isNotEmpty) {
                                                          var currentOrder =
                                                              orders.first
                                                                  .data();
                                                          return InkWell(
                                                            onTap: () {
                                                              controller
                                                                  .bottomNavbarController
                                                                  .currentIndex
                                                                  .value = 1;
                                                              controller
                                                                  .bottomNavbarController
                                                                  .pageController
                                                                  .value
                                                                  .jumpToPage(
                                                                      1);
                                                            },
                                                            child: Container(
                                                              height: 55,
                                                              width: 166,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  color: Colors
                                                                      .white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        offset: const Offset(
                                                                            0,
                                                                            2),
                                                                        blurRadius:
                                                                            12,
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.25))
                                                                  ]),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      'Perbaikan ${currentOrder['title']}',
                                                                      style: GoogleFonts.poppins(
                                                                          textStyle: const TextStyle(
                                                                              fontSize: 8,
                                                                              fontWeight: FontWeight.w600))),
                                                                  Text(
                                                                      currentOrder[
                                                                          'desc_error'],
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: GoogleFonts.poppins(
                                                                          textStyle: const TextStyle(
                                                                              fontSize: 8,
                                                                              color: cotech))),
                                                                  Row(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          const Icon(
                                                                            CupertinoIcons.clock,
                                                                            size:
                                                                                8,
                                                                            color:
                                                                                cotech,
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                              'Menuggu Perbaikan',
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 8, color: cotech)))
                                                                        ],
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      }
                                                    }
                                                    return Container(
                                                      height: 55,
                                                      width: 166,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                offset:
                                                                    const Offset(
                                                                        0, 2),
                                                                blurRadius: 12,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.25))
                                                          ]),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            const Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: SizedBox(
                                                                width: 75,
                                                                child: Text(
                                                                  'TIdak ada pesanan terbaru',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          8),
                                                                ),
                                                              ),
                                                            ),
                                                            RotatedBox(
                                                                quarterTurns: 1,
                                                                child: Opacity(
                                                                  opacity: 0.5,
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/wind.png',
                                                                  ),
                                                                ))
                                                          ]),
                                                    );
                                                  }),
                                              const VerticalDivider(
                                                thickness: 2,
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            offset:
                                                                const Offset(
                                                                    0, 2),
                                                            blurRadius: 12,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.25))
                                                      ]),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: const [
                                                          Text(
                                                            'Jam Produktif',
                                                            style: TextStyle(
                                                                fontSize: 8),
                                                          ),
                                                          SizedBox(
                                                            width: 1,
                                                          ),
                                                          Icon(
                                                            CupertinoIcons
                                                                .question_circle,
                                                            size: 8,
                                                            color: cotech,
                                                          )
                                                        ],
                                                      ),
                                                      Text(
                                                        '${userData['productiveHours']}',
                                                        style: GoogleFonts.poppins(
                                                            textStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
