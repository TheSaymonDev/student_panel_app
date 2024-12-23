import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_panel/utils/app_colors.dart';

class CustomSwitch extends StatelessWidget {

  final bool current;
  final Function(bool) onChanged;
  final Widget Function(bool) iconBuilder;

  const CustomSwitch({super.key, required this.current, required this.onChanged, required this.iconBuilder});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66.w,
      child: AnimatedToggleSwitch<bool>.dual(
        style: ToggleStyle(
            backgroundColor:
            AppColors.primaryClr.withValues(alpha: 0.3),
            borderColor: AppColors.primaryClr,
            borderRadius: BorderRadius.circular(50.r)),
        styleBuilder: (b) => ToggleStyle(
            indicatorColor: AppColors.primaryClr),
        spacing: 0,
        current: current,
        first: false,
        second: true,
        borderWidth: 1.5.w,
        height: 36.0.h,
        onChanged: onChanged,
        iconBuilder: iconBuilder,
      ),
    );
  }
}