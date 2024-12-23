import 'package:get/get.dart';
import 'package:student_panel/screens/email_verification_screen/controllers/email_verification_controller.dart';
import 'package:student_panel/screens/email_verification_screen/controllers/resend_verification_controller.dart';

class EmailVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmailVerificationController());
    Get.lazyPut(() => ResendVerificationController());
  }
}
