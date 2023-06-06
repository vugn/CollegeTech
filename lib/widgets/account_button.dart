import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknisi_app/utils/color_palette.dart';

class AccountButton extends StatefulWidget {
  const AccountButton(
      {super.key,
      required this.imageAssets,
      required this.label,
      required this.isActive,
      required this.onTap});
  final String imageAssets;
  final String label;
  final bool isActive;
  final void Function() onTap;
  @override
  State<AccountButton> createState() => _AccountButtonState();
}

class _AccountButtonState extends State<AccountButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 137,
          height: 137,
          decoration: BoxDecoration(boxShadow: [
            widget.isActive
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
                      color: widget.isActive
                          ? cotech
                          : const Color(cotechSecondaryValue)),
                  borderRadius: BorderRadius.circular(12)),
              child: InkWell(
                onTap: widget.onTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.imageAssets,
                      width: 60,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.label,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: widget.isActive
                            ? cotech
                            : const Color(cotechSecondaryValue),
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
        widget.isActive
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
}
