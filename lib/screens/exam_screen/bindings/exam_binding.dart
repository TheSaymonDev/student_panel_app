import 'package:get/get.dart';
import 'package:student_panel/screens/exam_screen/controllers/exam_controller.dart';
import 'package:student_panel/screens/exam_screen/controllers/timer_controller.dart';

class ExamBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExamController());
    Get.lazyPut(() => TimerController());
  }
}
