import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_panel/screens/exam_screen/controllers/exam_controller.dart';
import 'package:student_panel/screens/exam_screen/controllers/timer_controller.dart';
import 'package:student_panel/utils/app_colors.dart';
import 'package:student_panel/utils/app_const_functions.dart';
import 'package:student_panel/widgets/custom_elevated_btn.dart';

class ExamScreen extends StatelessWidget {
  const ExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) =>
          AppConstFunctions.customWarningMessage(
              message: 'You must complete the exam before exiting!'),
      canPop: false,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: GetBuilder<ExamController>(
          builder: (controller) {
            return PageView.builder(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (page) => controller.onPageChanged(page),
              itemCount: controller.quizData.questions!.length,
              itemBuilder: (context, index) {
                final question = controller.quizData.questions![index];
                return _buildQuestionCard(context, controller, question, index);
              },
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 70.h,
      centerTitle: true,
      title: GetBuilder<TimerController>(
        builder: (controller) {
          return Column(
            children: [
              Icon(Icons.alarm, size: 20.sp),
              Gap(4.h),
              Text(controller.formattedTime,
                  style: Theme.of(context).textTheme.titleLarge),
            ],
          );
        },
      ),
    );
  }

  Widget _buildQuestionCard(
      BuildContext context, ExamController controller, question, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Gap(16.h),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Color(0xFFF7D08A)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuestionHeader(context, index, controller),
                  Text(
                    question.questionText!,
                    style: Get.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Text(
                      '?',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: AppColors.secondaryClr),
                    ),
                  )
                ],
              ),
            ),
          ),
          Gap(24.h),
          Column(
            children: List.generate(
              question.options!.length,
              (index) => GestureDetector(
                onTap: !controller.answered
                    ? () => controller.selectAnswer(index)
                    : null,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                  height: 56.h,
                  decoration: BoxDecoration(
                    border: !controller.answered
                        ? Border.all(
                            width: 1.5.w,
                            color: context.isDarkMode
                                ? AppColors.lightGreyClr
                                : AppColors.darkGreyClr)
                        : null,
                    borderRadius: BorderRadius.circular(8.r),
                    color: controller.getOptionColor(index),
                  ),
                  child: Text(
                    question.options![index],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: !controller.answered ? null : Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Gap(20.h),
          CustomElevatedBtn(
              onPressed:
                  controller.answered ? () => controller.nextQuestion() : null,
              width: 240.w,
              name: controller.btnText),
          Gap(20.h),
        ],
      ),
    );
  }

  Widget _buildQuestionHeader(
      BuildContext context, int index, ExamController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: Text(
        "${index + 1}/${controller.quizData.questions!.length}",
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: AppColors.secondaryClr),
        textAlign: TextAlign.start,
      ),
    );
  }
}
