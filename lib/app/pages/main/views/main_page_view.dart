import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/pages/main/controllers/main_page_controller.dart';
import 'package:teknisi_app/app/pages/tes_page.dart';
import 'package:teknisi_app/app/widgets/bottom_navbar.dart';

class MainPageView extends GetView<MainPageController> {
  const MainPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => BottomNavbar(
            currentIndex: controller.currentIndex.value,
            onTap: (value) => controller.navbarTap(value),
          )),
      body: Obx(() => PageView(
            controller: controller.pageController.value,
            children: const [MainPageView(), TESWIDGET()],
          )),
    );
  }
}
