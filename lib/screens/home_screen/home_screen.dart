import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_panel/screens/dashboard_screen/dashboard_screen.dart';
import 'package:student_panel/screens/explore_screen/explore_screen.dart';
import 'package:student_panel/screens/home_screen/controllers/bottom_nav_controller.dart';
import 'package:student_panel/screens/home_screen/widgets/home_end_drawer.dart';
import 'package:student_panel/utils/app_colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final _screens = [const ExploreScreen(), const DashboardScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      endDrawer: HomeEndDrawer(),
      body: GetBuilder<BottomNavController>(
        builder: (controller) {
          return _screens.elementAt(controller.selectedIndex);
        }
      ),
      bottomNavigationBar: GetBuilder<BottomNavController>(
        builder: (controller) {
          return Container(
            decoration: BoxDecoration(
              color: context.isDarkMode? AppColors.darkCardClr: AppColors.lightCardClr,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withValues(alpha: .1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                child: GNav(
                  gap: 8,
                  activeColor: AppColors.primaryClr,
                  iconSize: 24.sp,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: AppColors.primaryClr.withValues(alpha: 0.2),
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'HOME',
                    ),
                    GButton(
                      icon: Icons.dashboard_outlined,
                      text: 'DASHBOARD',
                    ),
                  ],
                  selectedIndex: controller.selectedIndex,
                  onTabChange: controller.changeScreen,
                ),
              ),
            ),
          );
        }
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

}
