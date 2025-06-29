import 'package:get/get.dart';
import 'package:student_panel/screens/home_screen/controllers/ongoing_exams_controller.dart';
import 'package:student_panel/screens/home_screen/controllers/recent_results_controller.dart';
import 'package:student_panel/screens/home_screen/controllers/user_info_controller.dart';
import 'package:student_panel/screens/home_screen/controllers/weekly_performance_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserInfoController());
    Get.lazyPut(
          () => OngoingExamsController(),
    );
    Get.lazyPut(
          () => RecentResultsController(),
    );
    Get.lazyPut(
          () => WeeklyPerformanceController(),
    );
  }
}
