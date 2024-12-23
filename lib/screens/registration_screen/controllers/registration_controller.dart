import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:student_panel/utils/app_const_functions.dart';

class RegistrationController extends GetxController {
  bool isLoading = false;
  bool isObscure = true;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final schoolNameController = TextEditingController();
  final classNameController = TextEditingController();
  final classCodeController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<bool> registerUser() async {
    _setLoading(true);

    final response = await FirebaseService().register(
      email: emailController.text,
      password: passwordController.text.trim(),
      name: nameController.text,
      schoolName: schoolNameController.text,
      className: classNameController.text,
      classCode: classCodeController.text,
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

  void toggleObscure() {
    isObscure = !isObscure;
    update();
  }

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }
}
