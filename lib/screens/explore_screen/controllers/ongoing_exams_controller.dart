import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_panel/screens/quiz_list_screen/models/quiz_model.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:student_panel/services/shared_preference_service.dart';
import 'package:student_panel/utils/app_const_functions.dart';

class OngoingExamsController extends GetxController {
  bool isLoading = false;
  List<QuizModel> ongoingQuizzes = [];

  late String classId;
  late String userId;

  @override
  void onInit() {
    super.onInit();
    classId = SharedPreferencesService().getClassId();
    userId = SharedPreferencesService().getUserId();
    _readOngoingUnattemptedQuizzesForAllSubjects();
  }

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<bool> _readOngoingUnattemptedQuizzesForAllSubjects() async {
    _setLoading(true);
    print('🔍 Step 1: Reading attempted quizIds for user: $userId in class: $classId');

    try {
      // Step 1: Read attempted quizIds
      final resultResponse = await FirebaseService().readResults(
        classId: classId,
        userId: userId,
      );

      List<String> attemptedQuizIds = [];

      if (resultResponse['success'] == true) {
        final resultDocs = resultResponse['data'];
        print('✅ Attempted results found: ${resultDocs.docs.length}');

        for (var doc in resultDocs.docs) {
          final data = doc.data() as Map<String, dynamic>;
          final quizId = data['quizId']?.toString() ?? '';
          print('📄 Attempted quizId: $quizId');
          if (quizId.isNotEmpty) {
            attemptedQuizIds.add(quizId);
          }
        }
      } else {
        print('❌ Failed to read attempted quizzes: ${resultResponse['message']}');
      }

      // Step 2: Read all subjects first
      final subjectResponse = await FirebaseService().readSubjects(classId: classId);

      if (subjectResponse['success'] != true) {
        _setLoading(false);
        AppConstFunctions.customErrorMessage(
            message: subjectResponse['message'] ?? 'Failed to load subjects');
        return false;
      }

      final subjectDocs = subjectResponse['data'];
      final subjectIds = subjectDocs.docs.map((doc) => doc.id).toList();

      print('📚 Found subjects: ${subjectIds.length}');

      List<QuizModel> allQuizzes = [];

      // Step 3: For each subject, get its quizzes
      for (var subjectId in subjectIds) {
        final quizResponse = await FirebaseService().readQuizzes(
          classId: classId,
          subjectId: subjectId,
        );

        if (quizResponse['success'] == true) {
          final quizDocs = quizResponse['data'];
          print('📘 Quizzes from subject $subjectId: ${quizDocs.docs.length}');

          final quizzes = quizDocs.docs.map<QuizModel>((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return QuizModel.fromFireStore(data, doc.id);
          }).toList();

          allQuizzes.addAll(quizzes);
        }
      }

      _setLoading(false);

      // Step 4: Filter unattempted
      final unattemptedQuizzes = allQuizzes
          .where((quiz) => !attemptedQuizIds.contains(quiz.id))
          .toList();

      print('🎯 Total unattempted quizzes: ${unattemptedQuizzes.length}');

      // Step 5: Filter ongoing quizzes using parsed endTime
      final now = DateTime.now();
      final dateFormat = DateFormat("d/M/yyyy - HH:mm");

      ongoingQuizzes = unattemptedQuizzes.where((quiz) {
        try {
          final endTimeStr = quiz.endTime; // stored as string
          final endTime = dateFormat.parse(endTimeStr!);
          print('⏰ Quiz: ${quiz.topicName} → endTime: $endTime');
          return endTime.isAfter(now);
        } catch (e) {
          print('❌ Invalid endTime format in quiz ${quiz.id}: $e');
          return false;
        }
      }).toList();

      print('🚀 Ongoing + Unattempted quizzes: ${ongoingQuizzes.length}');
      for (var quiz in ongoingQuizzes) {
        print('🟢 ${quiz.topicName} (id: ${quiz.id}) → ends at ${quiz.endTime}');
      }

      if (ongoingQuizzes.isEmpty) {
        AppConstFunctions.customErrorMessage(message: 'No ongoing unattempted quizzes found');
        return false;
      }

      return true;
    } catch (e) {
      _setLoading(false);
      print('🔥 Exception occurred: $e');
      AppConstFunctions.customErrorMessage(
        message: 'Something went wrong: ${e.toString()}',
      );
      return false;
    }
  }
}
