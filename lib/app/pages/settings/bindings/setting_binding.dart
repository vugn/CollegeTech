import 'package:get/get.dart';
import 'package:teknisi_app/app/pages/settings/controllers/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }
}
