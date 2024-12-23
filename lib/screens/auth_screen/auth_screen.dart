import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_panel/routes/app_routes.dart';
import 'package:student_panel/utils/app_urls.dart';
import 'package:student_panel/widgets/custom_elevated_btn.dart';
import 'package:student_panel/widgets/custom_outlined_btn.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppUrls.authImg,
              width: 280.w,
            ),
            Gap(32.h),
            CustomElevatedBtn(
                onPressed: () => Get.toNamed(AppRoutes.logInScreen),
                name: 'Login'),
            Gap(16.h),
            CustomOutlinedBtn(
                onPressed: () => Get.toNamed(AppRoutes.registrationScreen),
                name: 'Registration')
          ],
        ),
      ),
    );
  }
}
