import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomEmptyWidget extends StatelessWidget {

  final String title;
  const CustomEmptyWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.folder_fill, size: 50.sp),
          Gap(8.h),
          Text(title, style: Theme.of(context).textTheme.bodyMedium)
        ],
      ),
    );
  }
}
