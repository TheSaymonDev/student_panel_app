import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_panel/localizations/language_controller.dart';
import 'package:student_panel/routes/app_routes.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:student_panel/services/shared_preference_service.dart';
import 'package:student_panel/themes/theme_controller.dart';
import 'package:student_panel/utils/app_colors.dart';
import 'package:student_panel/widgets/custom_gradient_container.dart';
import 'package:student_panel/widgets/custom_switch.dart';

class HomeEndDrawer extends StatefulWidget {
  const HomeEndDrawer({super.key});

  @override
  State<HomeEndDrawer> createState() => _HomeEndDrawerState();
}

class _HomeEndDrawerState extends State<HomeEndDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildProfileInfo(context),
          Gap(16.h),
          _buildThemeAndLanguage(context),
          Gap(16.h),
          _buildLeaderBoardTile(context),
          Spacer(),
          _buildLogoutBtn(context),
          Gap(32.h)
        ],
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    final String studentName = 'MD. SAYMON';
    final String schoolName =
        'ABC Govt High School';
    final String className = 'Class 9';
    final String email = 'student@gmail.com';
    final String classCode = '123456';
    final String profileImageUrl =
        'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'; // Replace with actual image URL

    return CustomGradientContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(16.h),
          CircleAvatar(
            radius: 50.r,
            backgroundImage: NetworkImage(profileImageUrl),
            backgroundColor: AppColors.primaryClr.withValues(alpha: 0.1),
          ),
          Gap(8.h),
          Text(
            studentName,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
          ),
          Gap(12.h),
          Row(
            children: [
              Icon(
                Icons.school,
                color: Colors.white,
                size: 20.sp,
              ),
              Gap(4.w),
              Expanded(
                flex: 5,
                child: Text(
                  schoolName,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis, // Text কাটার জন্য
                  maxLines: 2, // সর্বোচ্চ ২ লাইন পর্যন্ত দেখাবে
                ),
              ),
              Gap(8.w),
              Icon(
                Icons.class_,
                color: Colors.white,
                size: 20.sp,
              ),
              Gap(4.w),
              Expanded(
                flex: 2,
                child: Text(
                  className,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis, // Text কাটার জন্য
                  maxLines: 2, // সর্বোচ্চ ২ লাইন পর্যন্ত দেখাবে
                ),
              ),
            ],
          ),
          Gap(4.h),
          Row(
            children: [
              Icon(
                Icons.email,
                color: Colors.white,
                size: 20.sp,
              ),
              Gap(4.w),
              Expanded(
                flex: 5,
                child: Text(
                  email,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis, // Text কাটার জন্য
                  maxLines: 2, // সর্বোচ্চ ২ লাইন পর্যন্ত দেখাবে
                ),
              ),
              Gap(8.w),
              Icon(
                Icons.code,
                color: Colors.white,
                size: 20.sp,
              ),
              Gap(4.w),
              Expanded(
                flex: 2,
                child: Text(
                  classCode,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis, // Text কাটার জন্য
                  maxLines: 2, // সর্বোচ্চ ২ লাইন পর্যন্ত দেখাবে
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _buildLeaderBoardTile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(
                color: context.isDarkMode
                    ? AppColors.lightGreyClr
                    : AppColors.darkGreyClr)),
        leading: Icon(
          Icons.leaderboard,
          size: 25.sp,
        ),
        title:
            Text('Leaderboard', style: Theme.of(context).textTheme.titleMedium),
        subtitle:
            Text('See your rank', style: Theme.of(context).textTheme.bodySmall),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Container _buildThemeAndLanguage(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
          color: context.isDarkMode
              ? AppColors.darkCardClr
              : AppColors.lightCardClr,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
              color: context.isDarkMode
                  ? AppColors.lightGreyClr
                  : AppColors.darkGreyClr)),
      child: Column(
        children: [
          Row(
            children: [
              Text('Theme', style: Theme.of(context).textTheme.bodyMedium),
              Spacer(),
              GetBuilder<ThemeController>(builder: (controller) {
                return CustomSwitch(
                    current: controller.isDark,
                    onChanged: (newValue) => controller.changeTheme(),
                    iconBuilder: (value) => Icon(
                          value ? Icons.dark_mode : Icons.light_mode,
                          size: 20.0.sp,
                        ));
              })
            ],
          ),
          Divider(
              color: context.isDarkMode
                  ? AppColors.lightGreyClr
                  : AppColors.darkGreyClr),
          Row(
            children: [
              Text('Language', style: Theme.of(context).textTheme.bodyMedium),
              Spacer(),
              GetBuilder<LanguageController>(builder: (controller) {
                return CustomSwitch(
                    current: controller.isEnglish,
                    onChanged: (newValue) => controller.changeLanguage(),
                    iconBuilder: (value) => Center(
                          child: Text(value ? 'En' : 'বাং',
                              style: Theme.of(context).textTheme.titleSmall),
                        ));
              })
            ],
          ),
        ],
      ),
    );
  }

  Padding _buildLogoutBtn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: OutlinedButton(
        onPressed: () {
          FirebaseService().signOut();
          SharedPreferencesService().clearUserId();
          Get.offAllNamed(AppRoutes.logInScreen);
        },
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.secondaryClr, width: 2.w),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.power, color: AppColors.secondaryClr),
            Gap(8.w),
            Text('Logout',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.secondaryClr))
          ],
        ),
      ),
    );
  }
}
