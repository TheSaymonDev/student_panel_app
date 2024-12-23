import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_panel/routes/app_routes.dart';
import 'package:student_panel/screens/registration_screen/controllers/registration_controller.dart';
import 'package:student_panel/utils/app_colors.dart';
import 'package:student_panel/utils/app_const_functions.dart';
import 'package:student_panel/utils/app_urls.dart';
import 'package:student_panel/utils/app_validators.dart';
import 'package:student_panel/widgets/custom_app_bar/custom_app_bar_with_title.dart';
import 'package:student_panel/widgets/custom_elevated_btn.dart';
import 'package:student_panel/widgets/custom_outlined_btn.dart';
import 'package:student_panel/widgets/custom_text_form_field.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final _registrationController = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithTitle(
          onPressed: () => Get.back(), title: 'Registration Form'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: SingleChildScrollView(
          child: Form(
            key: _registrationController.formKey,
            child: Column(
              children: [
                Gap(16.h),
                Image.asset(AppUrls.appLogoImg, width: 50.w),
                Gap(16.h),
                Text('Educora', style: Theme.of(context).textTheme.bodyLarge),
                Gap(8.h),
                Text(
                  'Online learning platform',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.secondaryClr),
                ),
                Gap(32.h),
                CustomTextFormField(
                  controller: _registrationController.nameController,
                  hintText: 'Full Name',
                  validator: AppValidators.requiredValidator,
                ),
                Gap(12.h),
                CustomTextFormField(
                  controller: _registrationController.schoolNameController,
                  hintText: 'School Name',
                  validator: AppValidators.requiredValidator,
                ),
                Gap(12.h),
                CustomTextFormField(
                  controller: _registrationController.classNameController,
                  hintText: 'Class',
                  validator: AppValidators.requiredValidator,
                ),
                Gap(12.h),
                CustomTextFormField(
                  controller: _registrationController.classCodeController,
                  hintText: 'Class Code',
                  validator: AppValidators.requiredValidator,
                ),
                Gap(12.h),
                CustomTextFormField(
                  controller: _registrationController.emailController,
                  hintText: 'Email',
                  validator: AppValidators.requiredValidator,
                ),
                Gap(12.h),
                GetBuilder<RegistrationController>(
                  builder: (controller) {
                    return CustomTextFormField(
                      controller: controller.passwordController,
                      hintText: 'Password',
                      obscureText: controller.isObscure,
                      validator: AppValidators.passwordValidator,
                      suffixIcon: IconButton(
                        onPressed: () => controller.toggleObscure(),
                        icon: Icon(
                            controller.isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 20.sp,
                            color: context.isDarkMode
                                ? AppColors.lightGreyClr
                                : AppColors.darkGreyClr),
                      ),
                    );
                  },
                ),
                Gap(32.h),
                GetBuilder<RegistrationController>(
                  builder: (controller) => controller.isLoading
                      ? AppConstFunctions.customCircularProgressIndicator
                      : CustomElevatedBtn(
                          onPressed: () => _formOnSubmit(controller),
                          name: 'Register Now'),
                ),
                Gap(16.h),
                CustomOutlinedBtn(
                  onPressed: () {
                    Get.toNamed(AppRoutes.emailVerificationScreen);
                  },
                  name: 'Already Registered? Login',
                ),
                Gap(32.h)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _formOnSubmit(RegistrationController controller) async {
    if (controller.formKey.currentState!.validate()) {
      final result = await controller.registerUser();
      if (result) {
        Get.toNamed(AppRoutes.emailVerificationScreen);
      }
    }
  }
}
