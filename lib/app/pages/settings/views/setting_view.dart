import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/app/pages/settings/controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
            stream: controller.userCredentialSnaphot,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.waiting ||
                  snapshot.connectionState != ConnectionState.none) {
                if (snapshot.hasData) {
                  var userData = jsonDecode(jsonEncode(snapshot.data!.data()));
                  var accountType = userData['accountType'];
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Center(
                          child: Text(
                            'Profil',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600)),
                          ),
                        ),
                        const SizedBox(
                          height: 36,
                        ),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: userData['profilePhoto'],
                              width: 100,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Center(
                          child: Text(
                            userData['fullName'],
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ),
                        accountType == 0
                            ? const SizedBox()
                            : Center(
                                child: Text(
                                  userData['birth'],
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF9B9B9B))),
                                ),
                              ),
                        const SizedBox(
                          height: 35,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 4),
                                      blurRadius: 16,
                                      color: const Color(0XFF061929)
                                          .withOpacity(0.10))
                                ]),
                                child: Material(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 13),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(CupertinoIcons.person),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Text(
                                                'Ubah Profil',
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                  fontSize: 16,
                                                )),
                                              )
                                            ],
                                          ),
                                          const Icon(
                                              CupertinoIcons.right_chevron)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 4),
                                      blurRadius: 16,
                                      color: const Color(0XFF061929)
                                          .withOpacity(0.10))
                                ]),
                                child: Material(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 13),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(CupertinoIcons.layers),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Text(
                                                'Riwayat Pesanan',
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                  fontSize: 16,
                                                )),
                                              )
                                            ],
                                          ),
                                          const Icon(
                                              CupertinoIcons.right_chevron)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 4),
                                      blurRadius: 16,
                                      color: const Color(0XFF061929)
                                          .withOpacity(0.10))
                                ]),
                                child: Material(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      controller.showLogOut();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 13),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            CupertinoIcons.chevron_left_square,
                                            color: Colors.redAccent,
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            'Keluar',
                                            style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.redAccent)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
