import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_panel/routes/app_routes.dart';
import 'package:student_panel/screens/quiz_list_screen/controllers/quiz_list_controller.dart';
import 'package:student_panel/screens/quiz_list_screen/models/quiz_model.dart';
import 'package:student_panel/utils/app_colors.dart';
import 'package:student_panel/utils/app_const_functions.dart';
import 'package:student_panel/widgets/custom_app_bar/custom_app_bar_with_title.dart';
import 'package:student_panel/widgets/custom_elevated_btn.dart';
import 'package:student_panel/widgets/custom_empty_widget.dart';
import 'package:student_panel/widgets/custom_outlined_btn.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBarWithTitle(onPressed: () => Get.back(), title: 'Quizzes'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: GetBuilder<QuizListController>(
          builder: (controller) => controller.isLoading
              ? AppConstFunctions.customCircularProgressIndicator
              : controller.quizzes.isEmpty
                  ? CustomEmptyWidget(title: 'No quiz found!')
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      itemCount: controller.quizzes.length,
                      itemBuilder: (context, index) {
                        final quizItem = controller.quizzes[index];
                        return ListTile(
                          onTap: () =>
                              _showRulesForExamDialog(context, quizItem),
                          tileColor: context.isDarkMode
                              ? AppColors.darkCardClr
                              : AppColors.lightCardClr,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            side: BorderSide(
                                color: context.isDarkMode
                                    ? AppColors.lightGreyClr
                                    : AppColors.darkGreyClr),
                          ),
                          title: Text(quizItem.topicName ?? '',
                              style: Theme.of(context).textTheme.titleMedium),
                          subtitle: Text(
                              'Duration: ${quizItem.timeDuration} | Questions: ${quizItem.questions!.length}',
                              style: Theme.of(context).textTheme.titleSmall),
                          trailing: Icon(Icons.arrow_forward),
                        );
                      },
                      separatorBuilder: (context, index) => Gap(12.h),
                    ),
        ),
      ),
    );
  }

  void _showRulesForExamDialog(BuildContext context, QuizModel quizItem) {
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
                    onPressed: () => Get.toNamed(
                          AppRoutes.examScreen,
                          arguments: {
                            'quizData': quizItem,
                            'subjectName':
                                Get.find<QuizListController>().subjectName
                          },
                        ),
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
