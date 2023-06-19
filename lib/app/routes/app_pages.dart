import 'package:get/get.dart';
import 'package:teknisi_app/app/pages/auth/login/bindings/login_binding.dart';
import 'package:teknisi_app/app/pages/auth/login/views/login_view.dart';
import 'package:teknisi_app/app/pages/auth/register/bindings/register_binding.dart';
import 'package:teknisi_app/app/pages/auth/register/views/register_view.dart';
import 'package:teknisi_app/app/pages/history/bindings/history_binding.dart';
import 'package:teknisi_app/app/pages/history/views/history_view.dart';
import 'package:teknisi_app/app/pages/home/bindings/home_binding.dart';
import 'package:teknisi_app/app/pages/home/views/home_view.dart';
import 'package:teknisi_app/app/pages/main/bindings/main_page_binding.dart';
import 'package:teknisi_app/app/pages/main/views/main_page_view.dart';
import 'package:teknisi_app/app/pages/order/bindings/order_binding.dart';
import 'package:teknisi_app/app/pages/order/views/order_view.dart';
import 'package:teknisi_app/app/pages/settings/bindings/setting_binding.dart';
import 'package:teknisi_app/app/pages/settings/views/setting_view.dart';
import 'package:teknisi_app/app/pages/tes_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
        name: _Paths.MAIN,
        page: () => const MainPageView(),
        binding: MainPageBinding()),
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        binding: HomeBinding()),
    GetPage(
        name: _Paths.LOGIN,
        page: () => const LoginView(),
        binding: LoginBinding()),
    GetPage(
        name: _Paths.ORDER,
        page: () => const OrderView(),
        binding: OrderBinding()),
    GetPage(
        name: _Paths.HISTORY,
        page: () => const HistoryView(),
        binding: HistoryBinding()),
    GetPage(
        name: _Paths.SETTING,
        page: () => const SettingView(),
        binding: SettingBinding()),
    GetPage(
        name: _Paths.REGISTER,
        page: () => const RegisterView(),
        binding: RegisterBinding()),
    GetPage(name: _Paths.TESWIDGET, page: () => const TESWIDGET())
  ];
}
