import 'package:get/get.dart';
import 'package:student_panel/screens/leaderboard_screen/models/leaderboard_user_model.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:student_panel/services/shared_preference_service.dart';
import 'package:student_panel/utils/app_const_functions.dart';

class LeaderboardController extends GetxController {
  bool isLoading = false;
  List<LeaderboardUserModel> leaderboardUsers = [];
  late String classId;

  Future<bool> fetchLeaderboard(String filter) async {
    _setLoading(true);
    final response = await FirebaseService().readLeaderboardData(
      classId: classId,
      filter: filter,
    );
    _setLoading(false);

    if (response['success'] == true) {
      leaderboardUsers = List<LeaderboardUserModel>.from(response['data']);
      return true;
    } else {
      AppConstFunctions.customErrorMessage(
          message: response['message'] ?? 'Something went wrong');
      return false;
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    classId = SharedPreferencesService().getClassId();
    fetchLeaderboard('today');
  }
}