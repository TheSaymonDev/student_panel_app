import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_panel/screens/quiz_list_screen/models/quiz_model.dart';
import 'package:student_panel/utils/app_colors.dart';

class OngoingExamCard extends StatelessWidget {
  const OngoingExamCard({
    super.key,
    required this.quizItem, required this.onPressed,
  });

  final QuizModel quizItem;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(
              color: context.isDarkMode
                  ? AppColors.lightGreyClr
                  : AppColors.darkGreyClr)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Icon(Icons.quiz),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6.h,
                children: [
                  Text('Subject Name: ${quizItem.subjectName}', style: Theme.of(context).textTheme.bodyMedium),
                  Text('Topic Name: ${quizItem.topicName}',
                      style: Theme.of(context).textTheme.titleSmall),
                  Text('Duration: ${quizItem.timeDuration} Min',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: context.isDarkMode
                              ? AppColors.lightGreyClr
                              : AppColors.darkGreyClr)),
                ],
              ),
            ),
            ElevatedButton(onPressed: onPressed, child: Text('Start'))
          ],
        ),
      ),
    );
  }
}
