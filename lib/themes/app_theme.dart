import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_panel/utils/app_colors.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBgClr,
  useMaterial3: true,
  fontFamily: 'Noto Sans Bengali',
  primaryColor: AppColors.primaryClr,
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryClr,
      onPrimary: AppColors.darkFontClr,
      secondary: AppColors.lightCardClr,
      onSecondary: AppColors.lightFontClr,
      error: AppColors.redClr,
      onError: AppColors.lightBgClr,
      surface: AppColors.lightCardClr,
      onSurface: AppColors.lightFontClr),
  textTheme: TextTheme(
    bodyLarge:
    TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w400, height: 1),
    bodyMedium:
    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, height: 1),
    bodySmall:
    TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400, height: 1),
    titleLarge:
    TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w700, height: 1),
    titleMedium:
    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, height: 1),
    titleSmall:
    TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, height: 1),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.primaryClr.withValues(alpha: 0.1),
    hintStyle: TextStyle(fontSize: 20.sp, color: AppColors.darkGreyClr, fontFamily: 'Noto Sans Bengali', fontWeight: FontWeight.w400),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.primaryClr, width: 2.w),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.primaryClr, width: 2.w),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.primaryClr, width: 2.w),
    ),
  ),
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.white
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBgClr,
  fontFamily: 'Noto Sans Bengali',
  useMaterial3: true,
  primaryColor: AppColors.primaryClr,
  colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryClr,
      onPrimary: AppColors.darkFontClr,
      secondary: AppColors.darkCardClr,
      onSecondary: AppColors.darkFontClr,
      error: AppColors.redClr,
      onError: AppColors.lightBgClr,
      surface: AppColors.darkCardClr,
      onSurface: AppColors.darkFontClr),
  textTheme: TextTheme(
    bodyLarge:
    TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w400, height: 1),
    bodyMedium:
    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, height: 1),
    bodySmall:
    TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400, height: 1),
    titleLarge:
    TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w700, height: 1),
    titleMedium:
    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, height: 1),
    titleSmall:
    TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, height: 1),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.primaryClr.withValues(alpha: 0.1),
    hintStyle: TextStyle(fontSize: 20.sp, color: AppColors.lightGreyClr, fontFamily: 'Noto Sans Bengali', fontWeight: FontWeight.w400),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.primaryClr, width: 2.w),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.primaryClr, width: 2.w),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.primaryClr, width: 2.w),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkCardClr,
  ),
);
