import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_panel/screens/result_history_screen/models/result_model.dart';
import 'package:student_panel/utils/app_colors.dart';

class RecentResultsCard extends StatelessWidget {
  const RecentResultsCard({super.key, required this.recentResultItem});

  final ResultModel recentResultItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: context.isDarkMode
          ? AppColors.darkCardClr
          : AppColors.lightCardClr,
      leading: CircleAvatar(
          backgroundColor: AppColors.primaryClr,
          child: Text(
              '${recentResultItem.correctAnswers.toString()}/${recentResultItem.totalQuestions.toString()}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white))),
      title: Text('Subject: ${recentResultItem.subjectName}',
          style: Theme.of(context).textTheme.bodyLarge),
      subtitle: Text('Topic: ${recentResultItem.topicName}',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(
              color: context.isDarkMode
                  ? AppColors.lightGreyClr
                  : AppColors.darkGreyClr)),
    );
  }
}
