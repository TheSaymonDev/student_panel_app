import 'package:get/get.dart';
import 'package:student_panel/screens/log_in_screen/controllers/log_in_controller.dart';

class LogInBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LogInController());
  }
}