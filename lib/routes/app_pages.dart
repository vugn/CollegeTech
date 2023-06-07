import 'package:get/get.dart';
import 'package:teknisi_app/ui/pages/auth/login.dart';
import 'package:teknisi_app/ui/pages/tes_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(name: _Paths.LOGIN, page: () => const LoginPage()),
    GetPage(name: _Paths.TESWIDGET, page: () => const TESWIDGET())
  ];
}
