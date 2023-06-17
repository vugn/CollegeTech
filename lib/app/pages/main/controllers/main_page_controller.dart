import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  Rx<PageController> pageController = PageController().obs;
  RxInt currentIndex = 0.obs;

  void navbarTap(int int) {
    currentIndex.value = int;
    pageController.value.jumpToPage(currentIndex.value);
  }
}
