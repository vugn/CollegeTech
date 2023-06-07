import 'package:flutter/material.dart';
import 'package:teknisi_app/app/utils/color_palette.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      this.node,
      this.size,
      this.icon,
      this.autofillHints,
      this.label,
      this.type,
      this.maxLines,
      this.suffixIcon,
      this.onPressed,
      required this.hint,
      this.isPassword,
      this.noLabel,
      this.textInputAction});
  final TextEditingController controller;
  final FocusNode? node;
  final Size? size;
  final Icon? icon;
  final Icon? suffixIcon;
  final String? label;
  final bool? noLabel;
  final String hint;
  final TextInputType? type;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final VoidCallback? onPressed;
  final bool? isPassword;
  final Iterable<String>? autofillHints;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        widget.controller.value.text.isNotEmpty
            ? BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 5,
                color: cotech.shade100)
            : const BoxShadow(color: Colors.transparent)
      ]),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.type,
        obscureText: widget.isPassword ?? false,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            filled: true,
            fillColor: const Color(0xFFF4F4F4),
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            enabledBorder: OutlineInputBorder(
                borderSide: widget.controller.value.text.isNotEmpty
                    ? const BorderSide(color: cotech)
                    : BorderSide.none,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: cotech),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            hintText: widget.hint,
            hintStyle: const TextStyle(color: Color(cotechSecondaryValue))),
      ),
    );
  }
}
