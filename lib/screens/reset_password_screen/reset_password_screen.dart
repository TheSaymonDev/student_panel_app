import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_panel/screens/reset_password_screen/controllers/reset_password_controller.dart';
import 'package:student_panel/utils/app_colors.dart';
import 'package:student_panel/utils/app_const_functions.dart';
import 'package:student_panel/widgets/custom_app_bar/custom_app_bar_with_title.dart';
import 'package:student_panel/widgets/custom_elevated_btn.dart';
import 'package:student_panel/widgets/custom_outlined_btn.dart';
import 'package:student_panel/widgets/custom_text_form_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final _resetPasswordController = Get.find<ResetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithTitle(
          onPressed: () => Get.back(), title: 'Reset Password'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: SingleChildScrollView(
          child: Form(
            key: _resetPasswordController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(120.h),
                Icon(
                  Icons.lock_reset,
                  size: 100.sp,
                  color: AppColors.primaryClr,
                ),
                Gap(20.h),
                Text(
                  'Forgot Your Password?',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                Gap(10.h),
                Text(
                  'Enter your registered email address below to receive a password reset link.',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: context.isDarkMode
                          ? AppColors.lightGreyClr
                          : AppColors.darkGreyClr),
                  textAlign: TextAlign.center,
                ),
                Gap(30.h),
                CustomTextFormField(
                  controller: _resetPasswordController.emailController,
                  hintText: 'Email Address',
                ),
                Gap(20.h),
                GetBuilder<ResetPasswordController>(
                  builder: (controller) => controller.isLoading
                      ? AppConstFunctions.customCircularProgressIndicator
                      : CustomElevatedBtn(
                          onPressed: () => _formOnSubmit(controller, context),
                          name: 'Send Reset Link',
                        ),
                ),
                Gap(16.h),
                CustomOutlinedBtn(
                    onPressed: () => Get.back(), name: 'Go Back to Login'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _formOnSubmit(
      ResetPasswordController controller, BuildContext context) async {
    if (controller.formKey.currentState!.validate()) {
      final result = await controller.resetPassword();
      if (result && context.mounted) {
        _showSuccessAlertDialog(context);
      }
    }
  }

  void _showSuccessAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryClr.withValues(alpha: 0.3),
                  ),
                  child: Icon(Icons.check_circle,
                      size: 30.sp, color: AppColors.primaryClr),
                ),
                Gap(20.h),
                Text(
                  'Success!',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Gap(12.h),
                Text(
                    "A password reset link has been sent to your email. Please check your inbox",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: context.isDarkMode
                            ? AppColors.lightGreyClr
                            : AppColors.darkGreyClr),
                    textAlign: TextAlign.center),
                Gap(20.h),
                CustomElevatedBtn(onPressed: () => Get.back(), name: 'Go Back to Login'),
              ],
            ),
          ),
        );
      },
    );
  }
}
