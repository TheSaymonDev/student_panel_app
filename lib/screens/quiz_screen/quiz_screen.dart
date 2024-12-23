import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_panel/screens/quiz_screen/controllers/quiz_controller.dart';
import 'package:student_panel/utils/app_colors.dart';
import 'package:student_panel/widgets/custom_elevated_btn.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: GetBuilder<QuizController>(
        builder: (controller) {
          return PageView.builder(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (page) => controller.onPageChanged(page),
            itemCount: controller.topicData.questions!.length,
            itemBuilder: (context, index) {
              final question = controller.topicData.questions![index];
              return _buildQuestionCard(context, controller, question, index);
            },
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 70.h,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.logout, size: 25.sp, color: Colors.white),
      ),
      title: GetBuilder<QuizController>(
        builder: (controller) {
          return Column(
            children: [
              const Icon(Icons.alarm, color: Colors.white),
              Gap(4.h),
              Text(controller.formattedTime,
                  style:
                      Get.textTheme.titleLarge!.copyWith(color: Colors.white)),
            ],
          );
        },
      ),
      actions: [
        SizedBox(
          height: 36.h,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryClr,
              side: BorderSide(color: Colors.white),
            ),
            onPressed: () => Get.find<QuizController>().submitQuiz(),
            child: Text('Submit',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white)),
          ),
        ),
        Gap(16.w),
      ],
    );
  }

  Widget _buildQuestionCard(
      BuildContext context, QuizController controller, question, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Gap(16.h),
          Expanded(
            child: Card(
              color: Colors.yellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.yellow),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
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
          ),
          Gap(24.h),
          for (int i = 0; i < question.options!.length; i++)
            GestureDetector(
              onTap: !controller.answered
                  ? () => controller.selectAnswer(i)
                  : null,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                height: 56.h,
                decoration: BoxDecoration(
                  border: !controller.answered
                      ? Border.all(width: 1.5.w, color: AppColors.primaryClr)
                      : null,
                  borderRadius: BorderRadius.circular(8.r),
                  color: controller.getOptionColor(i),
                ),
                child: Text(
                  question.options![i],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: !controller.answered? AppColors.primaryClr: Colors.white),
                ),
              ),
            ),
          Gap(20.h),
          CustomElevatedBtn(
            onPressed:
                controller.answered ? () => controller.nextQuestion() : null,
            width: 240.w,
            name: controller.btnText
          ),
          Gap(20.h),
        ],
      ),
    );
  }

  Widget _buildQuestionHeader(BuildContext context,int index, QuizController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.lightBgClr,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: Text(
        "${index + 1}/${controller.topicData.questions!.length}",
        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.secondaryClr),
        textAlign: TextAlign.start,
      ),
    );
  }
}
