import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/utils/color_palette.dart';
import 'package:teknisi_app/widgets/account_button.dart';
import 'package:teknisi_app/widgets/forms.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _passwordLoginController =
      TextEditingController();
  bool isUserActive = true;
  bool isTechnicianActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 85,
            ),
            Center(
              child: Text(
                "Pilih Tipe Akun !",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                  color: cotech,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AccountButton(
                    imageButton: true,
                    imageAssets: "assets/images/icons/user_ic.png",
                    label: 'Umum',
                    isActive: isUserActive,
                    onTap: () {
                      setState(() {
                        isUserActive = true;
                        isTechnicianActive = false;
                      });
                    },
                  ),
                  AccountButton(
                    imageButton: true,
                    imageAssets: "assets/images/icons/worker_ic.png",
                    label: 'Teknisi',
                    isActive: isTechnicianActive,
                    onTap: () {
                      setState(() {
                        isUserActive = false;
                        isTechnicianActive = true;
                      });
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: 224,
              child: Center(
                child: Text(
                  "Hai ${isTechnicianActive ? 'Teknisi' : 'Kamu'} ! \nSilahkan isi Formulir di bawah",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                    color: Color(cotechSecondaryValue),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  )),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailLoginController,
                    hint: 'e-Mail',
                    type: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: _passwordLoginController,
                    hint: 'Password',
                    isPassword: true,
                    type: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Lupa Password?',
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AccountButton(
                      label: 'Masuk',
                      size: Size(MediaQuery.of(context).size.width, 48),
                      isActive:
                          _passwordLoginController.value.text.isNotEmpty &&
                              _emailLoginController.value.text.isNotEmpty,
                      onTap: () {}),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum Punya Akun?"),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Daftar',
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      )),
    );
  }
}
