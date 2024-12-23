import 'package:get/get.dart';
import 'package:student_panel/screens/reset_password_screen/controllers/reset_password_controller.dart';

class ResetPasswordBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordController());
  }
}