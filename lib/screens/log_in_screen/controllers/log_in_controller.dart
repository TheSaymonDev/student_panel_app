import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:student_panel/services/shared_preference_service.dart';
import 'package:student_panel/utils/app_const_functions.dart';


class LogInController extends GetxController {
  bool isLoading = false;
  bool isObscure = true;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<bool> logInUser() async {
    _setLoading(true);

    final response = await FirebaseService().logIn(
        email: emailController.text,
        password: passwordController.text
    );

    _setLoading(false);

    if (response['success'] == true) {
      final userId = response['userId'];
      final classId = response['classId'];
      AppConstFunctions.customSuccessMessage(message: response['message']);
      SharedPreferencesService().saveUserId(userId);
      SharedPreferencesService().saveClassId(classId);
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
