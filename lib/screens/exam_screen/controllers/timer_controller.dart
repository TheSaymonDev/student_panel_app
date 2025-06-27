import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:student_panel/screens/exam_screen/controllers/exam_controller.dart';
import 'package:student_panel/utils/app_urls.dart';

class TimerController extends GetxController{

  final AudioPlayer timerPlayer = AudioPlayer();

  Timer? timer;
  double _remainingTimeInSeconds = 0;
  void startTimer(double time) {
    _remainingTimeInSeconds = time;
    final double totalTime = _remainingTimeInSeconds; // মোট সময় সংরক্ষণ
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTimeInSeconds > 0) {
        _remainingTimeInSeconds--;

        // যখন সময় মোট সময়ের ১০%-এর সমান হবে
        if (_remainingTimeInSeconds == (totalTime * 0.10).toInt()) {
          _playTimerSound();
        }

        update();
      } else {
        Get.find<ExamController>().navigateToResult();
      }
    });
  }

  String get formattedTime {
    final minutes = (_remainingTimeInSeconds ~/ 60).toInt();
    final seconds = (_remainingTimeInSeconds % 60).toInt();
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  Future<void> _playTimerSound() async {
    await timerPlayer.setAsset(AppUrls.timerSound);
    await timerPlayer.play();
  }

  @override
  void onClose() {
    timerPlayer.dispose();
    timer?.cancel();
    super.onClose();
  }
}