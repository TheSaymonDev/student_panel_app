import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_panel/utils/app_colors.dart';

class OngoingExamCard extends StatelessWidget {
  const OngoingExamCard({super.key});

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
                  Text('General Knowledge',
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text('History of Bangladesh',
                      style: Theme.of(context).textTheme.titleSmall),
                  Text('Duration: 20 Min',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: context.isDarkMode
                              ? AppColors.lightGreyClr
                              : AppColors.darkGreyClr)),
                ],
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Start'))
          ],
        ),
      ),
    );
  }
}
