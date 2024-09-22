import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SeraTextfield extends StatelessWidget {
  const SeraTextfield(
      {super.key,
      this.focusNode,
      this.controller,
      this.prefixIcon,
      this.suffixIcon,
      this.label,
      this.labelColor,
      this.fillColor,
      this.cursorColor,
      this.inputColor,
      this.placeholder,
      this.onTap,
      this.maxLines,
      this.maxLength,
      this.forceErrorText,
      this.error,
      this.validator,
      this.inputFormatters,
      this.readOnly = false,
      this.required = false,
      this.onChanged,
      this.onSaved,
      this.keyboardType,
      this.textInputAction,
      this.onFieldSubmitted,
      this.obscureText,
      this.autofocus = false});
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? label;
  final Color? labelColor;
  final Color? fillColor;
  final Color? inputColor;
  final Color? cursorColor;
  final String? placeholder;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool required;
  final bool? obscureText;
  final bool readOnly;
  final bool autofocus;
  final int? maxLines;
  final int? maxLength;
  final String? forceErrorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? error;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      textInputAction: textInputAction,
      autofocus: autofocus,
      focusNode: focusNode,
      controller: controller,
      style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
          height: 1.43,
          color: inputColor ?? Colors.black87),
      cursorColor: cursorColor ?? Colors.black54,
      onTap: onTap,
      readOnly: readOnly,
      maxLines: obscureText == true ? 1 : maxLines,
      validator: validator,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLength: maxLength,
      forceErrorText: forceErrorText,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: placeholder,
        hintStyle: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter',
            height: 1.43,
            color: Color(0xFFD5D7DB)),
        error: error,
        label: RichText(
            text: TextSpan(
                text: label,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    height: 1.33,
                    color: labelColor ?? const Color(0xFFD5D7DB)),
                children: [
              required
                  ? const TextSpan(
                      text: " * ",
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                          height: 1.33,
                          color: Colors.red),
                    )
                  : const TextSpan()
            ])),
        floatingLabelStyle: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter',
            height: 1.33,
            color: Color(0xFF101010)),
        labelStyle: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter',
            height: 1.43,
            color: labelColor ?? const Color(0xFF101010)),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 12.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD5D7DB), width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
        fillColor: fillColor ?? Colors.white,
        hoverColor: const Color(0xFFD5D7DB),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        focusColor: const Color(0xFFD5D7DB),
      ),
    );
  }
}
