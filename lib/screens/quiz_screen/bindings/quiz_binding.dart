import 'package:get/get.dart';
import 'package:student_panel/screens/quiz_screen/controllers/quiz_controller.dart';

class QuizBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => QuizController());
  }
}