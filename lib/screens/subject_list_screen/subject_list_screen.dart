import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:student_panel/routes/app_routes.dart';
import 'package:student_panel/screens/subject_list_screen/controllers/subject_list_controller.dart';
import 'package:student_panel/utils/app_const_functions.dart';
import 'package:student_panel/utils/app_urls.dart';
import 'package:student_panel/widgets/custom_app_bar/custom_app_bar_with_title.dart';
import 'package:student_panel/widgets/custom_empty_widget.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Static color list
    final List<Color> colors = [
      Color(0xFFFB7F7F),
      Color(0xFFBA7DFF),
      Color(0xFF21DC71),
      Colors.orangeAccent,
      Color(0xFF709CFF),
      Colors.lightBlue,
    ];

    return Scaffold(
      appBar:
          CustomAppBarWithTitle(onPressed: () => Get.back(), title: 'Subjects'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: GetBuilder<SubjectListController>(
          builder: (controller) => controller.isLoading
              ? AppConstFunctions.customCircularProgressIndicator
              : controller.subjects.isEmpty
                  ? CustomEmptyWidget(title: 'No subject added!')
                  : GridView.builder(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      itemCount: controller.subjects.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 10 / 6,
                      ),
                      itemBuilder: (context, index) {
                        final subjectItem = controller.subjects[index];
                        return GestureDetector(
                          onTap: () => Get.toNamed(
                            AppRoutes.quizListScreen,
                            arguments: {
                              'subjectId': subjectItem.id,
                              'subjectName': subjectItem.subjectName
                            },
                          ),
                          child: Stack(
                            children: [
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                color: colors[index %
                                    colors.length], // Card color based on index
                                child: Center(
                                  child: Text(subjectItem.subjectName ?? '',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(color: Colors.white)),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                child: Image.asset(
                                  AppUrls.appLogoImg,
                                  width: 25.w,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
