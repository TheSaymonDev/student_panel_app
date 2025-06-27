import 'package:get/get.dart';
import 'package:student_panel/screens/quiz_list_screen/models/quiz_model.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:student_panel/services/shared_preference_service.dart';
import 'package:student_panel/utils/app_const_functions.dart';

class QuizListController extends GetxController {
  late String classId;
  late String userId;
  late String subjectId;
  late String subjectName;
  bool isLoading = false;
  List<QuizModel> quizzes = [];

  Future<bool> _readUnattemptedQuizzes({
    required String classId,
    required String subjectId,
    required String userId,
  }) async {
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

      // Step 2: Read all quizzes
      print('🔍 Step 2: Reading all quizzes for subject: $subjectId');
      final quizResponse = await FirebaseService().readQuizzes(
        classId: classId,
        subjectId: subjectId,
      );

      _setLoading(false);

      if (quizResponse['success'] == true) {
        final quizDocs = quizResponse['data'];
        print('✅ Total quizzes found: ${quizDocs.docs.length}');

        final allQuizzes = quizDocs.docs.map<QuizModel>((doc) {
          final data = doc.data() as Map<String, dynamic>;
          print('📘 Quiz loaded: ${data['title'] ?? doc.id} (id: ${doc.id})');
          return QuizModel.fromFireStore(data, doc.id);
        }).toList();

        // Step 3: Filter unattempted quizzes
        quizzes = allQuizzes
            .where((quiz) => !attemptedQuizIds.contains(quiz.id))
            .toList();

        print('🎯 Unattempted quizzes count: ${quizzes.length}');
        for (var quiz in quizzes) {
          print('🆕 Unattempted Quiz: ${quiz.topicName} (id: ${quiz.id})');
        }

        if (quizzes.isEmpty) {
          AppConstFunctions.customErrorMessage(message: 'All quizzes are attempted');
          return false;
        }

        return true;
      } else {
        AppConstFunctions.customErrorMessage(
          message: quizResponse['message'] ?? 'Failed to load quizzes',
        );
        return false;
      }
    } catch (e) {
      _setLoading(false);
      print('🔥 Exception occurred: $e');
      AppConstFunctions.customErrorMessage(
        message: 'Something went wrong: ${e.toString()}',
      );
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
    subjectId = Get.arguments['subjectId'] as String;
    subjectName = Get.arguments['subjectName'] as String;
    _readUnattemptedQuizzes(
        classId: classId, subjectId: subjectId, userId: userId);
  }
}
