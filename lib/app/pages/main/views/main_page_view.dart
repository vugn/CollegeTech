import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/pages/history/views/history_view.dart';
import 'package:teknisi_app/app/pages/home/views/home_view.dart';
import 'package:teknisi_app/app/pages/main/controllers/main_page_controller.dart';
import 'package:teknisi_app/app/pages/order/views/order_view.dart';
import 'package:teknisi_app/app/pages/settings/views/setting_view.dart';
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
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController.value,
            children: const [
              HomeView(),
              OrderView(),
              HistoryView(),
              SettingView()
            ],
          )),
    );
  }
}
