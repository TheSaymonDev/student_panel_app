import 'package:get/get.dart';
import 'package:student_panel/screens/explore_screen/controllers/ongoing_exams_controller.dart';
import 'package:student_panel/screens/explore_screen/controllers/recent_results_controller.dart';
import 'package:student_panel/screens/explore_screen/controllers/weekly_performance_controller.dart';

class ExploreBinding implements Bindings {
  @override
  void dependencies() {
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
