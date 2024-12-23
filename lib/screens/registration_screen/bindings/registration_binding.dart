import 'package:get/get.dart';
import 'package:student_panel/screens/registration_screen/controllers/registration_controller.dart';

class RegistrationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistrationController());
  }
}
