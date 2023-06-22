import 'package:get/get.dart';
import 'package:teknisi_app/app/pages/order/controllers/detail_crash_controller.dart';
import 'package:teknisi_app/app/pages/order/controllers/order_controller.dart';
import 'package:teknisi_app/app/pages/order/controllers/brands_controller.dart';
import 'package:teknisi_app/app/pages/order/controllers/technician_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController());
    Get.lazyPut<BrandsController>(() => BrandsController());
    Get.lazyPut<TechniciansController>(() => TechniciansController());
    Get.lazyPut<DetailCrashController>(() => DetailCrashController());
  }
}
