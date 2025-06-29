import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_panel/routes/app_routes.dart';
import 'package:student_panel/screens/home_screen/controllers/ongoing_exams_controller.dart';
import 'package:student_panel/screens/home_screen/controllers/recent_results_controller.dart';
import 'package:student_panel/screens/home_screen/widgets/home_end_drawer.dart';
import 'package:student_panel/screens/home_screen/widgets/ongoing_exam_card.dart';
import 'package:student_panel/screens/home_screen/widgets/performance_graph.dart';
import 'package:student_panel/screens/home_screen/widgets/quick_access_card.dart';
import 'package:student_panel/screens/home_screen/widgets/recent_results_card.dart';
import 'package:student_panel/screens/quiz_list_screen/models/quiz_model.dart';
import 'package:student_panel/utils/app_colors.dart';
import 'package:student_panel/utils/app_const_functions.dart';
import 'package:student_panel/widgets/custom_elevated_btn.dart';
import 'package:student_panel/widgets/custom_empty_widget.dart';
import 'package:student_panel/widgets/custom_outlined_btn.dart';

class HomeScreen extends StatelessWidget {
   const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      endDrawer: HomeEndDrawer(),
      body: Padding(
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
                      onTap: () => Get.toNamed(AppRoutes.resultHistoryScreen),
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
      ),
    );
  }

   AppBar _buildAppBar() {
     return AppBar(
       toolbarHeight: 56.h,
       leading: IconButton(
           onPressed: () {}, icon: Icon(CupertinoIcons.arrow_left_circle_fill)),
       actions: [
         Builder(builder: (context) {
           return IconButton(
               onPressed: () {
                 Scaffold.of(context).openEndDrawer();
               },
               icon: Icon(CupertinoIcons.person_circle_fill));
         }),
         Gap(4.w)
       ],
     );
   }

   Widget _buildOngoingExams() {
     return GetBuilder<OngoingExamsController>(
         builder: (controller) => controller.isLoading
             ? AppConstFunctions.customCircularProgressIndicator
             : controller.ongoingQuizzes.isEmpty
             ? CustomEmptyWidget(
           title: 'No ongoing exams available now',
         )
             : ListView.separated(
           padding: EdgeInsets.symmetric(vertical: 4.h),
           shrinkWrap: true,
           physics: NeverScrollableScrollPhysics(),
           itemCount: controller.ongoingQuizzes.length,
           itemBuilder: (context, index) {
             final quizItem = controller.ongoingQuizzes[index];
             return OngoingExamCard(
               quizItem: quizItem,
               onPressed: () =>
                   _showRulesForExamDialog(context, quizItem),
             );
           },
           separatorBuilder: (context, index) => Gap(0.h),
         ));
   }

   Widget _buildRecentResults() {
     return GetBuilder<RecentResultsController>(
       builder: (controller) => controller.isLoading
           ? AppConstFunctions.customCircularProgressIndicator
           : controller.recentResults.isEmpty
           ? CustomEmptyWidget(
         title: 'No recent result available now',
       )
           : ListView.separated(
         padding: EdgeInsets.symmetric(vertical: 12.h),
         shrinkWrap: true,
         physics: NeverScrollableScrollPhysics(),
         itemCount: controller.recentResults.length,
         separatorBuilder: (context, index) => Gap(12.h),
         itemBuilder: (context, index) {
           final recentResultItem = controller.recentResults[index];
           return RecentResultsCard(
               recentResultItem: recentResultItem);
         },
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
