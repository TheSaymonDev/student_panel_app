import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:student_panel/utils/app_colors.dart';

class CustomGradientContainer extends StatelessWidget {
  final Widget child;

  const CustomGradientContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity.w,
      alignment: Alignment.center,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: context.isDarkMode
              ? [AppColors.primaryClr, AppColors.secondaryClr]
              : [Colors.lightBlueAccent, Colors.greenAccent],
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: child,
    );
  }
}