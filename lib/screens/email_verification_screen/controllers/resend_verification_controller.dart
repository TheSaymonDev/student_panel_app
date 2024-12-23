import 'dart:async';
import 'package:get/get.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:student_panel/utils/app_const_functions.dart';

class ResendVerificationController extends GetxController {
  bool isLoading = false;
  Future<bool> resendVerification() async {
    _setLoading(true);
    final response = await FirebaseService().resendEmailVerification();

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
