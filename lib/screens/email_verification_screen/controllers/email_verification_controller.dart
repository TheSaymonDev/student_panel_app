import 'dart:async';

import 'package:get/get.dart';
import 'package:student_panel/screens/registration_screen/controllers/registration_controller.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:student_panel/utils/app_const_functions.dart';

class EmailVerificationController extends GetxController {
  bool isLoading = false;
  Future<bool> verifyEmail() async {
    _setLoading(true);
    final registrationController = Get.find<RegistrationController>();
    final response = await FirebaseService().completeRegistration(
      email: registrationController.emailController.text,
      name: registrationController.nameController.text,
      schoolName: registrationController.schoolNameController.text,
      className: registrationController.classNameController.text,
      classCode: registrationController.classCodeController.text,
    );

    _setLoading(false);

    if (response['success'] == true) {
      AppConstFunctions.customSuccessMessage(message: response['message']);
      return true;
    } else {
      AppConstFunctions.customErrorMessage(
          message: response['message'] ?? 'Something went wrong');
      return false;
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }
}
