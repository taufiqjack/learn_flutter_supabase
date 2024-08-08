import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final bool isEnabled;
  final Color? buttonTextColor;
  final Color? buttonBackgroundColor;
  final Color? borderColor;
  final Size? size;
  final double? fontSize;
  final Function()? onTap;

  const CommonButton({
    Key? key,
    required this.buttonText,
    this.isEnabled = true,
    this.buttonTextColor,
    this.buttonBackgroundColor,
    this.onTap,
    this.size,
    this.borderColor,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isEnabled ? onTap : null,
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: borderColor ?? transparent)),
          backgroundColor: isEnabled ? buttonBackgroundColor ?? red : greyThree,
          fixedSize: size ?? Size(MediaQuery.of(context).size.width, 48)),
      child: Text(buttonText,
          style: TextStyle(
            fontSize: fontSize ?? 14,
            color: isEnabled ? buttonTextColor ?? white : white,
          )),
    );
  }
}
