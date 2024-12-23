import 'package:get/get.dart';
import 'package:student_panel/screens/explore_screen/controllers/question_controller.dart';

class ExploreBinding implements Bindings{
  @override
  void dependencies() {
   Get.put(QuestionController());
  }
}