// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const MAIN = _Paths.MAIN;
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const ORDER = _Paths.ORDER;
  static const DETAILORDER = _Paths.DETAILORDER;
  static const TECHNICIANLIST = _Paths.TECHNICIANLIST;
  static const BRANDLIST = _Paths.BRANDLIST;
  static const CRASHDETAIL = _Paths.CRASHDETAIL;
  static const HISTORY = _Paths.HISTORY;
  static const SETTING = _Paths.SETTING;
  static const TESWIDGET = _Paths.TESWIDGET;
  static const REGISTER = _Paths.REGISTER;

  static const NAV_BOTTOM = _Paths.NAV_BOTTOM;
}

abstract class _Paths {
  static const MAIN = '/';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const ORDER = '/order';
  static const DETAILORDER = '/detailOrder';
  static const TECHNICIANLIST = '/techList';
  static const BRANDLIST = '/brands';
  static const CRASHDETAIL = '/crashDetail';
  static const HISTORY = '/history';
  static const SETTING = '/setting';
  static const TESWIDGET = '/test';

  static const REGISTER = '/register';
  static const NAV_BOTTOM = '/nav_bottom';
}
