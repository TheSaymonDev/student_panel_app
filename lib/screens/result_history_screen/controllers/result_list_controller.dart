import 'package:get/get.dart';
import 'package:student_panel/screens/result_history_screen/models/result_model.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:student_panel/services/shared_preference_service.dart';
import 'package:student_panel/utils/app_const_functions.dart';

class ResultListController extends GetxController{

  int quizzesTaken = 0;
  double averageScore = 0;
  double bestScore = 0;
  bool isLoading = false;
  List<ResultModel> results = [];
  late String classId;
  late String userId;

  Future<bool> _readResults() async {
    _setLoading(true);
    final response = await FirebaseService().readResults(classId: classId, userId: userId);
    _setLoading(false);
    if (response['success'] == true) {
      final data = response['data'];
      if (data.docs.isNotEmpty) {
        results = data.docs.map<ResultModel>((doc) {
          return ResultModel.fromFireStore(doc.data(), doc.id);
        }).toList();
        _calculateAnalytics();
        return true;
      } else {
        results = [];
        AppConstFunctions.customErrorMessage(message: 'No result found');
        return false;
      }
    } else {
      AppConstFunctions.customErrorMessage(
          message: response['message'] ?? 'Something went wrong');
      return false;
    }
  }

  /// Calculates quizzesTaken, averageScore, bestScore
  void _calculateAnalytics() {
    quizzesTaken = results.length;
    if (quizzesTaken == 0) {
      averageScore = 0;
      bestScore = 0;
      return;
    }

    double totalScore = 0;
    double highestScore = 0;

    for (var result in results) {
      double score = result.scorePercentage ?? 0;
      totalScore += score;
      if (score > highestScore) {
        highestScore = score;
      }
    }

    averageScore = totalScore / quizzesTaken;
    bestScore = highestScore;
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
    _readResults();
  }
}