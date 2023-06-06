// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const REG_PASIEN_UMUM = _Paths.REG_PASIEN_UMUM;
  static const REG_PASIEN_BPJS = _Paths.REG_PASIEN_BPJS;
  static const REG_PASIEN_LAMA = _Paths.REG_PASIEN_LAMA;

  static const POLI_FORM = _Paths.POLI_FORM;
  static const POLI_TICKET = _Paths.POLI_TICKET;

  static const NAV_BOTTOM = _Paths.NAV_BOTTOM;
  static const LIST_POLI = _Paths.LIST_POLI;

  static const USER_UPDATE_PASIEN_BPJS = _Paths.USER_UPDATE_PASIEN_BPJS;
  static const USER_UPDATE_PASIEN_UMUM = _Paths.USER_UPDATE_PASIEN_UMUM;

  static const PILIH_PASIEN = _Paths.PILIH_PASIEN;
  static const LIST_USER = _Paths.LIST_USER;
  static const LIST_POLI_ADMIN = _Paths.LIST_POLI_ADMIN;
  static const UPDATE_POLI = _Paths.UPDATE_POLI;

  static const UPDATE_PASIEN_BPJS = _Paths.UPDATE_PASIEN_BPJS;
  static const UPDATE_PASIEN_UMUM = _Paths.UPDATE_PASIEN_UMUM;
}

abstract class _Paths {
  static const HOME = '/home';
  static const LOGIN = '/login';

  static const REGISTER = '/register';
  static const REG_PASIEN_UMUM = '/regPasienUmum';
  static const REG_PASIEN_BPJS = '/regPasienBpjs';
  static const REG_PASIEN_LAMA = '/regPasienLama';

  static const POLI_FORM = '/poli_form';
  static const POLI_TICKET = '/poli_ticket';
  static const NAV_BOTTOM = '/nav_bottom';
  static const LIST_POLI = '/list_poli';

  static const USER_UPDATE_PASIEN_BPJS = '/user_update_pasien_bpjs';
  static const USER_UPDATE_PASIEN_UMUM = '/user_update_pasien_umum';

  static const PILIH_PASIEN = '/pilih_pasien';
  static const LIST_USER = '/list_user';
  static const LIST_POLI_ADMIN = '/list_poli_admin';
  static const UPDATE_POLI = '/update_poli';

  static const UPDATE_PASIEN_BPJS = '/update_pasien_bpjs';
  static const UPDATE_PASIEN_UMUM = '/update_pasien_umum';
}
