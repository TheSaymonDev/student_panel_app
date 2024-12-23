import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_panel/routes/app_routes.dart';
import 'package:student_panel/screens/email_verification_screen/controllers/email_verification_controller.dart';
import 'package:student_panel/screens/email_verification_screen/controllers/resend_verification_controller.dart';
import 'package:student_panel/utils/app_colors.dart';
import 'package:student_panel/utils/app_const_functions.dart';
import 'package:student_panel/widgets/custom_app_bar/custom_app_bar_with_title.dart';
import 'package:student_panel/widgets/custom_elevated_btn.dart';
import 'package:student_panel/widgets/custom_outlined_btn.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithTitle(
        onPressed: () => Get.back(),
        title: 'Verify Email',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.email_outlined,
              size: 100.sp,
              color: AppColors.primaryClr,
            ),
            Gap(20.h),
            Text(
              'Verify Your Email',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            Gap(10.h),
            Text(
              'We have sent a verification link to your email address. Please check your inbox and click on the link to verify your account.',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: context.isDarkMode
                      ? AppColors.lightGreyClr
                      : AppColors.darkGreyClr),
              textAlign: TextAlign.center,
            ),
            Gap(40.h),
            GetBuilder<ResendVerificationController>(
                builder: (controller) => controller.isLoading
                    ? AppConstFunctions.customCircularProgressIndicator
                    : CustomElevatedBtn(
                        onPressed: () async{
                          await controller.resendVerification();
                        }, name: 'Resend Verification Email')),
            Gap(20.h),
            GetBuilder<EmailVerificationController>(
                builder: (controller) => controller.isLoading
                    ? AppConstFunctions.customCircularProgressIndicator
                    : CustomElevatedBtn(
                        onPressed: () => _formOnSubmit(controller),
                        name: 'Check Verification Status',
                        bgClr: AppColors.greenClr)),
            Gap(30.h),
            CustomOutlinedBtn(onPressed: () => Get.back(), name: 'Cancel')
          ],
        ),
      ),
    );
  }

  void _formOnSubmit(EmailVerificationController controller) async {
    final result = await controller.verifyEmail();
    if (result) {
      Get.offAllNamed(AppRoutes.logInScreen);
    }
  }
}
