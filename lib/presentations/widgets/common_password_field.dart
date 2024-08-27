import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';

class CommonPasswordField extends StatelessWidget {
  final int? maxLines;
  final TextEditingController? controller;
  final Color? fillColor;
  final double? fontSize;
  final TextInputType keyboardType;
  final TextInputAction action;
  final VoidCallback? onClick;
  final Widget? suffixIcon;
  final bool obsecure;
  final bool showPassword;
  final VoidCallback onClickShowPassword;
  final bool readOnly;
  final bool useLabel;
  final String? validatorText;
  final bool? filled;
  final String hintText;
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  const CommonPasswordField({
    this.maxLines,
    super.key,
    this.controller,
    required this.keyboardType,
    this.obsecure = false,
    this.showPassword = true,
    required this.onClickShowPassword,
    this.readOnly = false,
    this.useLabel = true,
    this.fillColor,
    this.filled,
    this.suffixIcon,
    this.fontSize,
    required this.action,
    this.onClick,
    required this.hintText,
    this.validatorText,
    this.prefixIcon,
    this.validator,
    this.autovalidateMode,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      maxLines: maxLines ?? 1,
      obscureText: obsecure == true && showPassword == true,
      controller: controller,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: black),
      keyboardType: keyboardType,
      textInputAction: action,
      readOnly: readOnly,
      onTap: () => readOnly == true ? onClick!() : {},
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: filled != null ? true : false,
        prefixIcon: prefixIcon,
        labelStyle: TextStyle(fontSize: fontSize, color: greyThree),
        counterText: "",
        labelText: hintText,
        suffixIcon: obsecure == true
            ? IconButton(
                icon: Icon(
                  showPassword == true
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: showPassword == true ? greyThree : greyThree,
                ),
                onPressed: () => onClickShowPassword(),
              )
            : null,
        suffix: suffixIcon,
        hintText: hintText,
        hintStyle: const TextStyle(color: greyThree),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: greyThree),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: greyThree),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: greyThree),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
    );
  }
}
