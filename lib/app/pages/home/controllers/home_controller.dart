import 'package:carousel_slider/carousel_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_auth.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_functions.dart';

class HomeController extends GetxController {
  final FirebaseAuthentication _authentication = FirebaseAuthentication();
  final FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  // Carousel
  final Rx<CarouselController> carouselController = CarouselController().obs;
  RxInt carouselCurrent = 0.obs;

  User? currentUser;

  @override
  void onInit() {
    currentUser = _authentication.currentUser();
    super.onInit();
  }
}
