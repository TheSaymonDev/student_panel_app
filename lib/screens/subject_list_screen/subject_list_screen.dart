import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:student_panel/routes/app_routes.dart';
import 'package:student_panel/utils/app_urls.dart';
import 'package:student_panel/widgets/custom_app_bar/custom_app_bar_with_title.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Static subject list
    final List<String> subjects = [
      "Mathematics",
      "Physics",
      "Chemistry",
      "Biology",
      "English",
      "History",
      "Geography",
      "Computer Science",
      "Economics",
    ];

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
        child: GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          itemCount: subjects.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 10.w, // Horizontal spacing
            mainAxisSpacing: 10.h, // Vertical spacing
            childAspectRatio: 10 / 6, // Width to height ratio
          ),
          itemBuilder: (context, index) {
            return _buildSubjectCard(
              subjects[index],
              colors[index % colors.length],
              context,
            );
          },
        ),
      ),
    );
  }

  Widget _buildSubjectCard(
      String subjectName, Color cardColor, BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.topicListScreen),
      child: Stack(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            color: cardColor, // Card color based on index
            child: Center(
              child: Text(subjectName,
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
  }
}
