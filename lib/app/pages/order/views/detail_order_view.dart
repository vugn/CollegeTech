import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/pages/order/controllers/order_controller.dart';
import 'package:teknisi_app/app/utils/color_palette.dart';

class DetailOrderView extends GetView<OrderController> {
  DetailOrderView({super.key});

  final orderData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print(orderData);
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: 131,
            decoration: const BoxDecoration(color: cotech),
            child: Column(
              children: [],
            ),
          )
        ],
      ),
    );
  }
}
