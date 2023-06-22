import 'package:get/get.dart';
import 'package:teknisi_app/app/pages/address/controllers/address_controller.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressController>(() => AddressController());
  }
}
