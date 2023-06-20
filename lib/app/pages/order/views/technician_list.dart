import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/app/pages/order/controllers/order_controller.dart';
import 'package:teknisi_app/app/routes/app_pages.dart';
import 'package:teknisi_app/app/utils/color_palette.dart';
import 'package:teknisi_app/app/widgets/account_button.dart';

class TechnicianListOrder extends GetView<OrderController> {
  const TechnicianListOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      )),
    );
  }
}
