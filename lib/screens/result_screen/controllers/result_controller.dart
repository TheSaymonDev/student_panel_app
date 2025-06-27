import 'package:get/get.dart';
import 'package:confetti/confetti.dart';
import 'package:just_audio/just_audio.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:student_panel/services/shared_preference_service.dart';
import 'package:student_panel/utils/app_const_functions.dart';
import 'package:student_panel/utils/app_urls.dart';

class ResultController extends GetxController {

  bool isLoading = false;
  late int score;
  late int outOf;
  late String subjectName;
  late String topicName;
  late String quizId;

  late final ConfettiController confettiController;
  final AudioPlayer _passedPlayer = AudioPlayer();
  final AudioPlayer _failedPlayer = AudioPlayer();

  bool isPassed = false;

  @override
  void onInit() {
    super.onInit();
    score = Get.arguments['score'] as int;
    outOf = Get.arguments['outOf'] as int;
    subjectName = Get.arguments['subjectName'] as String;
    topicName = Get.arguments['topicName'] as String;
    quizId = Get.arguments['quizId'] as String;
    confettiController = ConfettiController();
    _evaluateResult();
  }

  void _evaluateResult() {
    final double passingScore = (40 / 100) * outOf; // 40% passing criteria

    if (score >= passingScore) {
      isPassed = true;
      confettiController.play();
      _playPassedMusic();
    } else {
      isPassed = false;
      confettiController.stop();
      _playFailedMusic();
    }

    update(); // Update the UI
  }

  Future<void> _playPassedMusic() async {
    await _passedPlayer.setAudioSource(AudioSource.asset(AppUrls.passedSound));
    await _passedPlayer.play();
  }

  Future<void> _playFailedMusic() async {
    await _failedPlayer.setAudioSource(AudioSource.asset(AppUrls.failedSound));
    await _failedPlayer.play();
  }

  Future<bool> submitQuizResult() async {
    _setLoading(true);
    final response = await FirebaseService().submitQuizResult(
      classId: SharedPreferencesService().getClassId(),
      userId: SharedPreferencesService().getUserId(),
      subjectName: subjectName,
      topicName: topicName,
      totalQuestions: outOf,
      correctAnswers: score,
      quizId: quizId,
    );
    _setLoading(false);

    if (response['success'] == true) {
      AppConstFunctions.customSuccessMessage(message: response['message']);
      return true;
    } else {
      AppConstFunctions.customErrorMessage(
          message: response['message'] ?? 'Something went wrong');
      return false;
    }
  }

  @override
  void onClose() {
    confettiController.dispose();
    _passedPlayer.dispose();
    _failedPlayer.dispose();
    super.onClose();
  }

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }


}
