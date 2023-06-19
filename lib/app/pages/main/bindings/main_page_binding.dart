import 'package:get/get.dart';
import 'package:teknisi_app/app/pages/history/controllers/history_controller.dart';
import 'package:teknisi_app/app/pages/home/controllers/home_controller.dart';
import 'package:teknisi_app/app/pages/main/controllers/main_page_controller.dart';
import 'package:teknisi_app/app/pages/order/controllers/order_controller.dart';
import 'package:teknisi_app/app/pages/settings/controllers/setting_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainPageController>(
      MainPageController(),
    );
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<OrderController>(() => OrderController());
    Get.lazyPut<HistoryController>(() => HistoryController());
    Get.lazyPut<SettingController>(() => SettingController());
  }
}
