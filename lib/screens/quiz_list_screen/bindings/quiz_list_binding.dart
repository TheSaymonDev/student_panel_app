import 'package:get/get.dart';
import 'package:student_panel/screens/quiz_list_screen/controllers/quiz_list_controller.dart';


class QuizListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuizListController());
  }
}
