import 'package:get/get.dart';
import 'package:student_panel/screens/home_screen/models/user_model.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:student_panel/services/shared_preference_service.dart';
import 'package:student_panel/utils/app_const_functions.dart';

class UserInfoController extends GetxController {
  bool isLoading = false;
  UserModel? userData;

  Future<bool> _readUserInfo() async {
    _setLoading(true);
    final classId = SharedPreferencesService().getClassId();
    final userId = SharedPreferencesService().getUserId();

    if (classId.isEmpty || userId.isEmpty) {
      AppConstFunctions.customErrorMessage(message: 'Invalid user or class ID');
      _setLoading(false);
      return false;
    }
    final response = await FirebaseService().readCurrentUserData(
      classId: classId,
      userId: userId,
    );
    _setLoading(false);
    if (response['success'] == true) {
      final data = response['data'];
      if (data != null) {
        userData = UserModel.fromFireStore(data.data(), data.id);
        return true;
      } else {
        AppConstFunctions.customErrorMessage(message: 'No data found');
        return false;
      }
    } else {
      AppConstFunctions.customErrorMessage(
        message: response['message'] ?? 'Something went wrong',
      );
      return false;
    }
  }

  void refreshClass() {
    _readUserInfo();
  }

  @override
  void onInit() {
    super.onInit();
    _readUserInfo();
  }

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }
}
