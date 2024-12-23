import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:student_panel/utils/app_const_functions.dart';

class ResetPasswordController extends GetxController {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  Future<bool> resetPassword() async {
    _setLoading(true);
    final response = await FirebaseService().resetPassword(
      email: emailController.text,
    );
    _setLoading(false);
    if (response['success'] == true) {
      AppConstFunctions.customSuccessMessage(message: response['message']);
      emailController.clear();
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
