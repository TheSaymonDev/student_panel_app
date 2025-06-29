import 'package:get/get.dart';
import 'package:student_panel/screens/leaderboard_screen/controllers/leaderboard_controller.dart';

class LeaderboardBinding implements Bindings {
  @override
  void dependencies() {
  Get.put(LeaderboardController());
  }
}
