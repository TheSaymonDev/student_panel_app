import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_panel/routes/app_routes.dart';
import 'package:student_panel/screens/explore_screen/widgets/ongoing_exam_card.dart';
import 'package:student_panel/screens/explore_screen/widgets/performance_graph.dart';
import 'package:student_panel/screens/explore_screen/widgets/quick_access_card.dart';
import 'package:student_panel/utils/app_colors.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(16.h),
            Row(
              spacing: 6.w,
              children: [
                QuickAccessCard(
                    onTap: () => Get.toNamed(AppRoutes.subjectListScreen),
                    title: 'Start Quiz',
                    cardClr: Colors.green,
                    icon: Icons.play_arrow),
                QuickAccessCard(
                    onTap: () {},
                    title: 'Results',
                    cardClr: Colors.blue,
                    icon: Icons.history),
                QuickAccessCard(
                    onTap: () {},
                    title: 'Resources',
                    cardClr: Colors.orange,
                    icon: Icons.book),
              ],
            ),
            Gap(16.h),
            Text('Your Weekly Performance',
                style: Theme.of(context).textTheme.titleMedium),
            Gap(4.h),
            PerformanceGraph(),
            Gap(16.h),
            Text('Ongoing Exams',
                style: Theme.of(context).textTheme.titleMedium),
            _buildOngoingExams(),
            Gap(16.h),
            Text('Recent Results',
                style: Theme.of(context).textTheme.titleMedium),
            _buildRecentResults(),
          ],
        ),
      ),
    );
  }





  Widget _buildOngoingExams() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return OngoingExamCard();
      },
      separatorBuilder: (context, index) => Gap(0.h),
    );
  }

  Widget _buildRecentResults() {

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.primaryClr,
            child:
                Text('33/50', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white))
          ),
          title: Text('General knowledge', style: Theme.of(context).textTheme.bodyLarge),
          subtitle: Text('Topic: History of Bangladesh',  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: context.isDarkMode
                  ? AppColors.lightGreyClr
                  : AppColors.darkGreyClr)),
        );
      },
    );
  }
}
