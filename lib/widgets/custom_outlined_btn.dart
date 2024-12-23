import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_panel/utils/app_colors.dart';

class CustomOutlinedBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;
  final double? width;
  final double? height;

  const CustomOutlinedBtn({
    super.key,
    required this.onPressed,
    required this.name,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity.w,
      height: height ?? 50.h,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.secondaryClr, width: 2.w),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r))),
          onPressed: onPressed,
          child: Text(name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: AppColors.secondaryClr))),
    );
  }
}