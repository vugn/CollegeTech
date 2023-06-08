import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/routes/app_pages.dart';
import 'package:teknisi_app/app/utils/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.cupertino,
      title: 'CoTech Indonesia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: cotech, fontFamily: GoogleFonts.poppins().fontFamily),
      initialRoute: Routes.LOGIN,
      getPages: AppPages.routes,
    );
  }
}
