import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:teknisi_app/app/utils/color_palette.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.controller,
      this.dropdownController,
      this.node,
      this.size,
      this.icon,
      this.autofillHints,
      this.type,
      this.maxLines,
      this.suffixIcon,
      this.isMultiDropdown = false,
      this.label,
      this.onTap,
      this.readOnly,
      this.errorText,
      this.dropdownList,
      required this.hint,
      this.isDropdown = false,
      this.isPassword,
      this.style,
      this.noLabel,
      this.expands,
      this.onChange,
      this.textInputAction});
  final TextEditingController? controller;
  final dynamic dropdownController;
  final FocusNode? node;
  final Size? size;
  final Icon? icon;
  final Icon? suffixIcon;
  final String? label;
  final String? errorText;
  final bool? readOnly;
  final bool? expands;
  final bool? isMultiDropdown;
  final bool? noLabel;
  final bool isDropdown;
  final TextStyle? style;
  final List<DropDownValueModel>? dropdownList;
  final String hint;
  final TextInputType? type;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final VoidCallback? onTap;
  final Function(String)? onChange;
  final bool? isPassword;
  final Iterable<String>? autofillHints;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return widget.isDropdown
        ? dropdownField(
            controller: widget.dropdownController,
            hint: widget.hint,
            autofillHints: widget.autofillHints,
            expands: widget.expands,
            icon: widget.icon,
            isPassword: widget.isPassword,
            label: widget.label,
            dropdownList: widget.dropdownList,
            maxLines: widget.maxLines,
            isMultiDropdown: widget.isMultiDropdown,
            noLabel: widget.noLabel,
            node: widget.node,
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            size: widget.size,
            suffixIcon: widget.suffixIcon,
            textInputAction: widget.textInputAction,
            type: widget.type,
          )
        : Container(
            decoration: BoxDecoration(boxShadow: [
              widget.controller!.value.text.isNotEmpty
                  ? BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      color: cotech.shade100)
                  : const BoxShadow(color: Colors.transparent)
            ]),
            child: TextField(
              textAlignVertical: TextAlignVertical.top,
              controller: widget.controller,
              keyboardType: widget.type,
              autofocus: true,
              maxLines: widget.maxLines,
              expands: widget.expands ?? false,
              obscureText: widget.isPassword ?? false,
              textInputAction: widget.textInputAction,
              readOnly: widget.readOnly ?? false,
              onTap: widget.onTap,
              style: widget.style,
              onChanged: widget.onChange,
              decoration: InputDecoration(
                  errorText: widget.errorText,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  filled: true,
                  suffixIcon: widget.icon,
                  fillColor: const Color(0xFFF4F4F4),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: widget.controller!.value.text.isNotEmpty
                          ? const BorderSide(color: cotech)
                          : BorderSide.none,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: cotech),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  hintText: widget.hint,
                  hintStyle:
                      const TextStyle(color: Color(cotechSecondaryValue))),
            ),
          );
  }
}

Widget dropdownField(
    {required dynamic controller,
    FocusNode? node,
    Size? size,
    Icon? icon,
    Icon? suffixIcon,
    String? label,
    bool? readOnly,
    bool? expands,
    bool? noLabel,
    bool? isMultiDropdown,
    List<DropDownValueModel>? dropdownList,
    required String hint,
    TextInputType? type,
    int? maxLines,
    TextInputAction? textInputAction,
    VoidCallback? onTap,
    bool? isPassword,
    Iterable<String>? autofillHints}) {
  return isMultiDropdown! == true
      ? Container(
          decoration: BoxDecoration(boxShadow: [
            controller!.dropDownValueList != null
                ? BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 5,
                    color: cotech.shade100)
                : const BoxShadow(color: Colors.transparent)
          ]),
          child: DropDownTextField.multiSelection(
              dropDownIconProperty: IconProperty(
                  color: controller.dropDownValueList != null
                      ? cotech
                      : const Color(cotechSecondaryValue),
                  size: 32),
              clearOption: true,
              controller: controller,
              dropDownList: dropdownList ?? [],
              submitButtonColor: cotech,
              submitButtonTextStyle: const TextStyle(color: Colors.white),
              textFieldDecoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  filled: true,
                  suffixIcon: icon,
                  fillColor: const Color(0xFFF4F4F4),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: controller.dropDownValueList != null
                          ? const BorderSide(color: cotech)
                          : BorderSide.none,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: cotech),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  hintText: hint,
                  hintStyle:
                      const TextStyle(color: Color(cotechSecondaryValue))),
              onChanged: (item) {}),
        )
      : Container(
          decoration: BoxDecoration(boxShadow: [
            controller!.dropDownValue != null
                ? BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 5,
                    color: cotech.shade100)
                : const BoxShadow(color: Colors.transparent)
          ]),
          child: DropDownTextField(
              dropDownIconProperty: IconProperty(
                  color: controller.dropDownValue != null
                      ? cotech
                      : const Color(cotechSecondaryValue),
                  size: 32),
              clearOption: false,
              controller: controller,
              dropDownList: dropdownList ?? [],
              textFieldDecoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  filled: true,
                  suffixIcon: icon,
                  fillColor: const Color(0xFFF4F4F4),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: controller.dropDownValue != null
                          ? const BorderSide(color: cotech)
                          : BorderSide.none,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: cotech),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  hintText: hint,
                  hintStyle:
                      const TextStyle(color: Color(cotechSecondaryValue))),
              onChanged: (item) {}),
        );
}
