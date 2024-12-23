import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_panel/utils/app_colors.dart';

class CustomElevatedBtn extends StatelessWidget {
  final void Function()? onPressed;
  final String name;
  final double? width;
  final double? height;
  final Color? bgClr;

  const CustomElevatedBtn({
    super.key,
    required this.onPressed,
    required this.name,
    this.width,
    this.height,
    this.bgClr,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity.w,
      height: height ?? 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: bgClr ?? AppColors.primaryClr,
            foregroundColor: AppColors.lightBgClr,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
            padding: EdgeInsets.zero),
        onPressed: onPressed,
        child: Text(name,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white)),
      ),
    );
  }
}
