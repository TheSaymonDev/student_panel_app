import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_panel/routes/app_routes.dart';
import 'package:student_panel/utils/app_colors.dart';
import 'package:student_panel/widgets/custom_app_bar/custom_app_bar_with_title.dart';
import 'package:student_panel/widgets/custom_elevated_btn.dart';
import 'package:student_panel/widgets/custom_outlined_btn.dart';

class TopicListScreen extends StatelessWidget {
  TopicListScreen({super.key});

  final exams = [
    {'name': 'Algebra Basics', 'duration': '30 mins', 'questions': 20},
    {'name': 'Advanced Algebra', 'duration': '45 mins', 'questions': 30},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBarWithTitle(onPressed: () => Get.back(), title: 'Topics'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          itemCount: exams.length,
          itemBuilder: (context, index) {
            final exam = exams[index];
            return ListTile(
              onTap: () => _showRulesForExamDialog(context),
              tileColor: context.isDarkMode
                  ? AppColors.darkCardClr
                  : AppColors.lightCardClr,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(
                      color: context.isDarkMode
                          ? AppColors.lightGreyClr
                          : AppColors.darkGreyClr)),
              title: Text(exam['name'] as String,
                  style: Theme.of(context).textTheme.titleMedium),
              subtitle: Text(
                  'Duration: ${exam['duration']} | Questions: ${exam['questions']}',
                  style: Theme.of(context).textTheme.titleSmall),
              trailing: Icon(Icons.arrow_forward),
            );
          },
          separatorBuilder: (context, index) => Gap(12.h),
        ),
      ),
    );
  }

  void _showRulesForExamDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0.r)),
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
                  child: Icon(Icons.rule,
                      size: 30.sp, color: AppColors.primaryClr),
                ),
                Gap(20.h),
                Text('Rules for Exam',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center),
                Gap(12.h),
                Text(
                    "1. Read each question carefully.\n"
                    "2. You must answer all questions.\n"
                    "3. Time is limited, so manage your time wisely.\n"
                    "4. Avoid any distractions during the exam.\n"
                    "5. Once submitted, answers cannot be changed.",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        height: 1.5.h,
                        color: context.isDarkMode
                            ? AppColors.lightGreyClr
                            : AppColors.darkGreyClr),
                    textAlign: TextAlign.start),
                Gap(20.h),
                CustomElevatedBtn(
                    onPressed: () => Get.toNamed(AppRoutes.quizScreen),
                    name: 'Start Exam'),
                Gap(16.h),
                CustomOutlinedBtn(onPressed: () => Get.back(), name: 'Cancel')
              ],
            ),
          ),
        );
      },
    );
  }
}
