import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_panel/screens/result_history_screen/controllers/result_list_controller.dart';
import 'package:student_panel/utils/app_colors.dart';
import 'package:student_panel/utils/app_const_functions.dart';
import 'package:student_panel/widgets/custom_app_bar/custom_app_bar_with_title.dart';
import 'package:student_panel/widgets/custom_empty_widget.dart';
import 'package:student_panel/widgets/custom_gradient_container.dart';

class ResultHistoryScreen extends StatelessWidget {
  const ResultHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBarWithTitle(onPressed: () => Get.back(), title: 'Results'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overall Performance',
                style: Theme.of(context).textTheme.titleMedium),
            Gap(12.h),
            CustomGradientContainer(
              child: GetBuilder<ResultListController>(
                builder: (controller) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPerformanceTile(
                            title: 'Quizzes Taken', value: '${controller.quizzesTaken}'),
                        _buildPerformanceTile(
                            title: 'Average Score',
                            value: '${controller.averageScore.toStringAsFixed(1)}%'),
                        _buildPerformanceTile(
                            title: 'Best Score',
                            value: '${controller.bestScore.toStringAsFixed(1)}%'),
                      ],
                    ),
                    Gap(16.h),
                    LinearProgressIndicator(
                      value: (controller.averageScore / 100).clamp(0.0, 1.0),
                      color: Colors.lightGreenAccent,
                      backgroundColor: Colors.white,
                    ),
                    Gap(8.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('${controller.averageScore.toStringAsFixed(1)}% Completed',
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                  ],
                ),
              ),
            ),
            Gap(16.h),
            Text('Recent Results',
                style: Theme.of(context).textTheme.titleMedium),
            Gap(8.h),
            _buildRecentResults(),
          ],
        ),
      ),
    );
  }

  Expanded _buildRecentResults() {
    return Expanded(
      child: GetBuilder<ResultListController>(
        builder: (controller) => controller.isLoading
            ? AppConstFunctions.customCircularProgressIndicator
            : controller.results.isEmpty
                ? CustomEmptyWidget(title: 'No result available!')
                : ListView.separated(
                    itemCount: controller.results.length,
                    separatorBuilder: (context, index) => Gap(12.h),
                    itemBuilder: (context, index) {
                      final resultItem = controller.results[index];
                      return ListTile(
                        tileColor: context.isDarkMode
                            ? AppColors.darkCardClr
                            : AppColors.lightCardClr,
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryClr,
                          radius: 30.r,
                          child: Text(
                            '${resultItem.correctAnswers}/${resultItem.totalQuestions}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          resultItem.subjectName ?? '',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        subtitle: Text(
                          resultItem.topicName ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: context.isDarkMode
                                      ? AppColors.lightGreyClr
                                      : AppColors.darkGreyClr),
                        ),
                        trailing: Text(
                          '${resultItem.scorePercentage!.toInt()}%',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Widget _buildPerformanceTile({required String title, required String value}) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        Gap(4.h),
        Text(title,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
      ],
    );
  }
}
