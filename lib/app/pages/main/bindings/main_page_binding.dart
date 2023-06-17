import 'package:get/get.dart';
import 'package:teknisi_app/app/pages/main/controllers/main_page_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainPageController>(
      MainPageController(),
    );
  }
}
