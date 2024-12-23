import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:student_panel/screens/explore_screen/models/topic_model.dart';
import 'package:student_panel/screens/result_screen/result_screen.dart';
import 'package:student_panel/utils/app_urls.dart';
import 'package:student_panel/utils/app_colors.dart';

class QuizController extends GetxController {
  late TopicModel topicData;
  final PageController pageController = PageController();
  final AudioPlayer _correctAnswerPlayer = AudioPlayer();
  final AudioPlayer _wrongAnswerPlayer = AudioPlayer();
  // final AudioPlayer _timerPlayer = AudioPlayer();

  Timer? _timer;
  double _remainingTimeInSeconds = 0;
  int score = 0;
  bool answered = false;
  String btnText = "Next Question";

  @override
  void onInit() {
    super.onInit();
    topicData = Get.arguments['topicData'] as TopicModel;
    _remainingTimeInSeconds = topicData.questions!.length * topicData.timeDuration!.toDouble(); // Example: 15 sec/question
    _startTimer();
  }

  String get formattedTime {
    final minutes = (_remainingTimeInSeconds ~/ 60).toInt();
    final seconds = (_remainingTimeInSeconds % 60).toInt();
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTimeInSeconds > 0) {
        _remainingTimeInSeconds--;
        // if (_remainingTimeInSeconds == 60) _playTimerSound();
        update();
      } else {
        timer.cancel();
        _navigateToResult();
      }
    });
  }

  void onPageChanged(int page) {
    answered = false;
    if (page == topicData.questions!.length - 1) {
      btnText = "See Results";
    }
    update();
  }

  void selectAnswer(int index) async {
    if (index == topicData.questions![pageController.page!.toInt()].correctAnswer) {
      score++;
      await _playCorrectSound();
    } else {
      await _playWrongSound();
    }
    answered = true;
    update();
  }

  void nextQuestion() {
    if (pageController.page!.toInt() < topicData.questions!.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _navigateToResult();
    }
  }

  void submitQuiz() {
    _timer?.cancel();
    _navigateToResult();
  }

  Color getOptionColor(int index) {
    if (!answered) return Colors.white;
    return index == topicData.questions![pageController.page!.toInt()].correctAnswer
        ? AppColors.primaryClr
        : AppColors.redClr;
  }

  Future<void> _playCorrectSound() async {
    await _correctAnswerPlayer.setAsset(AppUrls.correctAnswerSound);
    await _correctAnswerPlayer.play();
  }

  Future<void> _playWrongSound() async {
    await _wrongAnswerPlayer.setAsset(AppUrls.wrongAnswerSound);
    await _wrongAnswerPlayer.play();
  }

  // Future<void> _playTimerSound() async {
  //   await _timerPlayer.setAsset(AppUrls.timerSound);
  //   await _timerPlayer.play();
  // }

  void _navigateToResult() {
    Get.to(() => ResultScreen(score: score, outOf: topicData.questions!.length));
  }

  @override
  void onClose() {
    _timer?.cancel();
    _correctAnswerPlayer.dispose();
    _wrongAnswerPlayer.dispose();
    // _timerPlayer.dispose();
    super.onClose();
  }
}
