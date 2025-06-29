import 'package:get/get.dart';
import 'package:student_panel/screens/result_history_screen/models/result_model.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:student_panel/services/shared_preference_service.dart';
import 'package:student_panel/utils/app_const_functions.dart';

class RecentResultsController extends GetxController{

  bool isLoading = false;
  List<ResultModel> recentResults = [];
  late String classId;
  late String userId;

  Future<bool> _fetchRecentResults() async {
    _setLoading(true);
    final response = await FirebaseService().readRecentResults(classId: classId, userId: userId);
    _setLoading(false);
    if (response['success'] == true) {
      final data = response['data'];
      if (data.docs.isNotEmpty) {
        recentResults = data.docs.map<ResultModel>((doc) {
          return ResultModel.fromFireStore(doc.data(), doc.id);
        }).toList();
        return true;
      } else {
        recentResults = [];
        AppConstFunctions.customErrorMessage(message: 'No result found');
        return false;
      }
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
    userId = SharedPreferencesService().getUserId();
    _fetchRecentResults();
  }
}