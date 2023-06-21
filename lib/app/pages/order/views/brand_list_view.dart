import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/app/pages/order/controllers/order_controller.dart';
import 'package:teknisi_app/app/pages/order/controllers/brands_controller.dart';

class BrandsList extends GetView<BrandsController> {
  const BrandsList({super.key});

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
                "Pilh Brand Yang Ingin Diperbaiki",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            SingleChildScrollView(
                child: GridView.count(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.65,
              children: List.generate(
                  controller.brandResult.brands.length,
                  (index) => Container(
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: controller.brandResult.brands[index]
                                    ['image'],
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
            ))
          ],
        ),
      ),
    );
  }
}
