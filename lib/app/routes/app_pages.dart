import 'package:get/get.dart';
import 'package:teknisi_app/app/pages/auth/login/bindings/login_binding.dart';
import 'package:teknisi_app/app/pages/auth/login/views/login_view.dart';
import 'package:teknisi_app/app/pages/auth/register/bindings/register_binding.dart';
import 'package:teknisi_app/app/pages/auth/register/views/register_view.dart';
import 'package:teknisi_app/app/pages/tes_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
        name: _Paths.LOGIN,
        page: () => const LoginView(),
        binding: LoginBinding()),
    GetPage(
        name: _Paths.REGISTER,
        page: () => const RegisterView(),
        binding: RegisterBinding()),
    GetPage(name: _Paths.TESWIDGET, page: () => const TESWIDGET())
  ];
}
