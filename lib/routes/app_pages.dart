import 'package:get/get.dart';
import 'package:teknisi_app/ui/pages/auth/login.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(name: _Paths.LOGIN, page: () => const LoginPage())
  ];
}
