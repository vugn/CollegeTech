import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/app/pages/home/controllers/home_controller.dart';
import 'package:teknisi_app/app/utils/color_palette.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cotech,
      body: FutureBuilder<QuerySnapshot?>(
        future: controller.firebaseFunctions
            .getUserCredential(controller.currentUser!.email!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userData =
                jsonDecode(jsonEncode(snapshot.data?.docs.first.data()));
            if (userData['accountType'] == 1) {
              return Stack(
                children: [
                  Container(
                    height: 132,
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
                                Text(
                                  userData['fullName'],
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
                  Container(
                    transform: Matrix4.translationValues(0.0, 140.0, 0.0),
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        color: Colors.white),
                  ),
                  Center(
                    child: Container(
                      transform: Matrix4.translationValues(0, -220.0, 0.0),
                      height: 121,
                      width: 312,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 2),
                                blurRadius: 12,
                                color: Colors.black.withOpacity(0.25))
                          ]),
                    ),
                  ),
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(userData['accountType'].toString()),
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
