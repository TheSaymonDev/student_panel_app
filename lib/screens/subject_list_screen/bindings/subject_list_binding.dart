import 'package:get/get.dart';
import 'package:student_panel/screens/subject_list_screen/controllers/subject_list_controller.dart';

class SubjectListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubjectListController());
  }
}
