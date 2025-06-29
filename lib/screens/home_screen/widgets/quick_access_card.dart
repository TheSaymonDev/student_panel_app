import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class QuickAccessCard extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final Color cardClr;
  final IconData icon;
  const QuickAccessCard(
      {super.key,
      required this.onTap,
      required this.title,
      required this.cardClr,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r)
          ),
          color: cardClr,
          child: SizedBox(
            height: 120.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40.sp, color: Colors.white),
                Gap(8.h),
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
