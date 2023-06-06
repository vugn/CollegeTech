import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/routes/app_pages.dart';
import 'package:teknisi_app/utils/color_palette.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CoTech Indonesia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: cotech,
      ),
      initialRoute: Routes.LOGIN,
      getPages: AppPages.routes,
    );
  }
}
