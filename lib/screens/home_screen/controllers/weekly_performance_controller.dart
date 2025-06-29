import 'package:get/get.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_panel/services/shared_preference_service.dart';

class WeeklyPerformanceController extends GetxController {
  bool isLoading = false;
  List<double> weeklyScores = [0, 0, 0, 0, 0]; // Sun - Thu

  late String classId;
  late String userId;

  @override
  void onInit() {
    super.onInit();
    classId = SharedPreferencesService().getClassId();
    userId = SharedPreferencesService().getUserId();
    _loadWeeklyPerformance();
  }

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> _loadWeeklyPerformance() async {
    _setLoading(true);

    final response = await FirebaseService().readResults(
      classId: classId,
      userId: userId,
    );

    if (response['success'] != true) {
      _setLoading(false);
      return;
    }

    final resultDocs = response['data'];
    Map<int, double> totalScores = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0};
    Map<int, int> countMap = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0};

    for (var doc in resultDocs.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final score = (data['scorePercentage'] ?? 0).toDouble();
      final attemptedAt = data['attemptedAt'];

      DateTime date = attemptedAt is Timestamp
          ? attemptedAt.toDate()
          : DateTime.tryParse(attemptedAt.toString()) ?? DateTime.now();

      int weekday = date.weekday % 7; // Sunday = 0

      if (weekday < 5) {
        totalScores[weekday] = totalScores[weekday]! + score;
        countMap[weekday] = countMap[weekday]! + 1;
      }
    }

    weeklyScores = List.generate(5, (index) {
      final total = totalScores[index]!;
      final count = countMap[index]!;
      return count > 0 ? total / count : 0;
    });

    _setLoading(false);
  }
}
