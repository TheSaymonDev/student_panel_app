import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_panel/screens/leaderboard_screen/controllers/leaderboard_controller.dart';
import 'package:student_panel/utils/app_colors.dart';
import 'package:student_panel/utils/app_const_functions.dart';

class LeaderboardWidget extends StatelessWidget {
  const LeaderboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaderboardController>(builder: (controller) {
      if (controller.isLoading) {
        return AppConstFunctions.customCircularProgressIndicator;
      }
      final topUsers = controller.leaderboardUsers.take(3).toList();
      final otherUsers = controller.leaderboardUsers.skip(3).toList();

      return Column(
        children: [
          if (topUsers.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(topUsers.length, (i) {
                return _buildLeaderItem(
                  rank: i + 1,
                  image: 'https://i.pravatar.cc/150?img=4',
                  userName: topUsers[i].username,
                  score: topUsers[i].totalScore.toString(),
                  context: context,
                  crown: i == 0,
                );
              }),
            ),
          Expanded(
            child: otherUsers.isEmpty
                ? const Center(child: Text('No more users'))
                : ListView.separated(
                    itemCount: otherUsers.length,
                    itemBuilder: (context, index) => _buildRankListItem(
                      rank: index + 4,
                      image: 'https://i.pravatar.cc/150?img=4',
                      userName: otherUsers[index].username,
                      score: otherUsers[index].totalScore.toString(),
                      context: context,
                    ),
                    separatorBuilder: (context, index) => Gap(2.h),
                  ),
          )
        ],
      );
    });
  }

  Widget _buildLeaderItem({
    required int rank,
    required String image,
    required String userName,
    required String score,
    bool crown = false,
    required BuildContext context,
  }) {
    return Column(
      children: [
        Text(
          '1',
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: AppColors.primaryClr),
        ),
        if (crown) Icon(Icons.emoji_events, color: Colors.amber, size: 40.sp),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: crown
                ? LinearGradient(
                    colors: [AppColors.primaryClr, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            border: Border.all(
              color: crown ? Colors.amber : AppColors.primaryClr,
              width: crown ? 3.w : 2.w,
            ),
          ),
          padding: EdgeInsets.all(4.w),
          child: CircleAvatar(
            radius: crown ? 40.r : 30.r,
            backgroundImage: NetworkImage(image),
          ),
        ),
        Gap(4.h),
        Text(userName, style: Theme.of(context).textTheme.bodyMedium),
        Text(score,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.greenClr)),
      ],
    );
  }

  Widget _buildRankListItem({
    required int rank,
    required String image,
    required String userName,
    required String score,
    required BuildContext context,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        child: Row(
          children: [
            Text(
              '$rank',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: AppColors.primaryClr),
            ),
            Gap(20.w),
            CircleAvatar(radius: 25.r, backgroundImage: NetworkImage(image)),
            Gap(20.w),
            Expanded(
              child:
                  Text(userName, style: Theme.of(context).textTheme.bodyMedium),
            ),
            Text(score,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColors.greenClr)),
          ],
        ),
      ),
    );
  }
}
