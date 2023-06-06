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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
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
                    "Hai Kamu ! Silahkan isi Formulis di bawah",
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
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      controller: _passwordLoginController,
                      hint: 'Password',
                      isPassword: true,
                      type: TextInputType.visiblePassword,
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
