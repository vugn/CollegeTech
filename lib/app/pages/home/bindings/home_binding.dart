import 'package:get/get.dart';
import 'package:teknisi_app/app/pages/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}
