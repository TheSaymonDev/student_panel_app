import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:student_panel/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    required this.controller,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.validator,
    this.keyBoardType,
    this.maxLines,
  });

  final String? hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextInputType? keyBoardType;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyMedium,
      controller: controller,
      cursorColor: AppColors.secondaryClr,
      readOnly: readOnly,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyBoardType,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        hintText: hintText ?? 'writeHere'.tr,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      ),
    );
  }
}