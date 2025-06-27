import 'package:get/get.dart';
import 'package:student_panel/screens/result_screen/controllers/result_controller.dart';

class ResultBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResultController());
  }
}
