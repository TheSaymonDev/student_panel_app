import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:student_panel/routes/app_routes.dart';
import 'package:student_panel/screens/exam_screen/controllers/timer_controller.dart';
import 'package:student_panel/screens/quiz_list_screen/models/quiz_model.dart';
import 'package:student_panel/utils/app_urls.dart';
import 'package:student_panel/utils/app_colors.dart';

class ExamController extends GetxController {
  late QuizModel quizData;
  final PageController pageController = PageController();
  final AudioPlayer _correctAnswerPlayer = AudioPlayer();
  final AudioPlayer _wrongAnswerPlayer = AudioPlayer();
  int score = 0;
  bool answered = false;
  String btnText = "Next Question";

  final _timerController = Get.find<TimerController>();

  @override
  void onInit() {
    super.onInit();
    quizData = Get.arguments['quizData'] as QuizModel;
    double time = quizData.questions!.length *
        double.parse(quizData.timeDuration!); // Example: 15 sec/question
    _timerController.startTimer(time);
  }

  void onPageChanged(int page) {
    answered = false;
    if (page == quizData.questions!.length - 1) {
      btnText = "See Results";
    }
    update();
  }

  void selectAnswer(int index) async {
    if (index ==
        quizData.questions![pageController.page!.toInt()].correctAnswer) {
      score++;
      await _playCorrectSound();
    } else {
      await _playWrongSound();
    }
    answered = true;
    update();
  }

  void nextQuestion() {
    if (pageController.page!.toInt() < quizData.questions!.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      navigateToResult();
    }
  }

  Color getOptionColor(int index) {
    if (!answered) {
      return Get.context!.isDarkMode
          ? AppColors.darkCardClr
          : AppColors.lightCardClr;
    }
    return index ==
            quizData.questions![pageController.page!.toInt()].correctAnswer
        ? const Color(0xFF68C29B)
        : const Color(0xFFE76D6D);
  }

  Future<void> _playCorrectSound() async {
    await _correctAnswerPlayer.setAsset(AppUrls.correctAnswerSound);
    await _correctAnswerPlayer.play();
  }

  Future<void> _playWrongSound() async {
    await _wrongAnswerPlayer.setAsset(AppUrls.wrongAnswerSound);
    await _wrongAnswerPlayer.play();
  }

  void navigateToResult() {
    _timerController.timer?.cancel(); // টাইমার বন্ধ করা
    _timerController.timerPlayer.stop(); // টাইমার সাউন্ড বন্ধ করা
    Get.offAndToNamed(
      AppRoutes.resultScreen,
      arguments: {
        'score': score,
        'outOf': quizData.questions!.length,
        'subjectName': quizData.subjectName,
        'topicName': quizData.topicName,
        'quizId': quizData.id
      },
    );
  }

  @override
  void onClose() {
    _correctAnswerPlayer.dispose();
    _wrongAnswerPlayer.dispose();
    super.onClose();
  }
}
