import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/utils/color_palette.dart';

class AccountButton extends StatefulWidget {
  const AccountButton(
      {super.key,
      this.imageAssets,
      required this.label,
      required this.isActive,
      required this.onTap,
      this.borderRadius,
      this.imageButton = false,
      this.size});
  final String? imageAssets;
  final String label;
  final BorderRadius? borderRadius;
  final Size? size;
  final bool isActive;
  final bool imageButton;
  final VoidCallback onTap;
  @override
  State<AccountButton> createState() => _AccountButtonState();
}

class _AccountButtonState extends State<AccountButton> {
  @override
  Widget build(BuildContext context) {
    return widget.imageButton
        ? imageButton(
            isActive: widget.isActive,
            imageAssets: widget.imageAssets ?? '',
            label: widget.label,
            onTap: widget.onTap)
        : filledButton(
            hint: widget.label,
            isActive: widget.isActive,
            borderRadius: widget.borderRadius,
            onTap: widget.onTap,
            size: widget.size ?? Size(MediaQuery.of(context).size.width, 48));
  }
}

Widget imageButton(
    {required bool isActive,
    required String imageAssets,
    required String label,
    required VoidCallback onTap}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: 137,
        height: 137,
        decoration: BoxDecoration(boxShadow: [
          isActive
              ? BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 12,
                  color: cotech.shade100)
              : const BoxShadow(color: Colors.transparent)
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Material(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1,
                    color:
                        isActive ? cotech : const Color(cotechSecondaryValue)),
                borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imageAssets,
                    width: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color:
                          isActive ? cotech : const Color(cotechSecondaryValue),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      isActive
          ? Positioned(
              bottom: -10,
              right: -10,
              child: Container(
                width: 33,
                height: 33,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), color: cotech),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ))
          : const SizedBox(),
    ],
  );
}

Widget filledButton(
    {required bool isActive,
    required String hint,
    required VoidCallback onTap,
    required Size size,
    BorderRadius? borderRadius}) {
  return FilledButton(
    onPressed: onTap,
    style: ButtonStyle(
        minimumSize: MaterialStatePropertyAll(size),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8))),
        backgroundColor: MaterialStatePropertyAll(
            isActive ? cotech : const Color(0xFFF4F4F4))),
    child: Text(
      hint,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
        color: isActive ? Colors.white : const Color(cotechSecondaryValue),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      )),
    ),
  );
}
