import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:student_panel/routes/app_routes.dart';
import 'package:student_panel/screens/result_screen/controllers/result_controller.dart';
import 'package:student_panel/utils/app_colors.dart';
import 'package:student_panel/utils/app_const_functions.dart';
import 'package:student_panel/utils/app_urls.dart';
import 'package:student_panel/widgets/custom_elevated_btn.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key});

  final _resultController = Get.find<ResultController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) =>
          AppConstFunctions.customWarningMessage(
              message: 'You must submit the result before exiting!'),
      canPop: false,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildResultAnimation(context),
                  _buildScoreCard(context),
                  GetBuilder<ResultController>(
                      builder: (controller) => controller.isLoading
                          ? AppConstFunctions.customCircularProgressIndicator
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32.w),
                              child: CustomElevatedBtn(
                                onPressed: () => _formOnSubmit(controller),
                                name: 'Submit',
                                height: 60.h,
                              ),
                            )),
                ],
              ),
            ),
          ),
          ConfettiWidget(
            confettiController: _resultController.confettiController,
            shouldLoop: true,
            blastDirectionality: BlastDirectionality.explosive,
          )
        ],
      ),
    );
  }

  Stack _buildScoreCard(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 25.h, horizontal: 32.w),
          padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 20.w),
          height: MediaQuery.of(context).size.height * .22,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: context.isDarkMode
                ? AppColors.darkCardClr
                : AppColors.lightCardClr,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildScoreBox(context, true),
              Gap(16.w),
              Text(
                ':',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.primaryClr, fontSize: 50.sp),
              ),
              Gap(16.w),
              _buildScoreBox(context, false),
            ],
          ),
        ),
        Positioned(
            right: 120,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? AppColors.darkBgClr
                      : AppColors.lightBgClr,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r))),
              child: Text("Final Score",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium),
            )),
      ],
    );
  }

  Expanded _buildScoreBox(BuildContext context, bool isScore) {
    return Expanded(
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: context.isDarkMode
                  ? AppColors.darkBgClr
                  : AppColors.lightBgClr),
          child: Text(
            isScore
                ? '${_resultController.score}'
                : '${_resultController.outOf}',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 50.sp),
          )),
    );
  }

  Widget _buildResultAnimation(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .20,
      child: Lottie.asset(
        _resultController.isPassed ? AppUrls.passedAnim : AppUrls.failedAnim,
      ),
    );
  }

  void _formOnSubmit(ResultController controller) async {
    final result = await controller.submitQuizResult();
    if (result) {
      Get.offAllNamed(AppRoutes.homeScreen);
    }
  }
}
