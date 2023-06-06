import 'package:flutter/material.dart';

const MaterialColor cotech = MaterialColor(_cotechPrimaryValue, <int, Color>{
  50: Color(0xFFFDF4E3),
  100: Color(0xFFFBE3B8),
  200: Color(0xFFF9D189),
  300: Color(0xFFF6BE5A),
  400: Color(0xFFF4B036),
  500: Color(_cotechPrimaryValue),
  600: Color(0xFFF09A11),
  700: Color(0xFFEE900E),
  800: Color(0xFFEC860B),
  900: Color(0xFFE87506),
});
const int _cotechPrimaryValue = 0xFFF2A213;

const MaterialColor cotechAccent =
    MaterialColor(_cotechAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_cotechAccentValue),
  400: Color(0xFFFFD0AA),
  700: Color(0xFFFFC191),
});
const int _cotechAccentValue = 0xFFFFECDD;
