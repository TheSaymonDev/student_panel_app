import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:student_panel/screens/registration_screen/models/class_model.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:student_panel/utils/app_const_functions.dart';

class RegistrationController extends GetxController {
  bool isLoading = false;
  bool isObscure = true;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final schoolNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  List<ClassModel> classes = [];
  String? selectedClass;

  Future<void> fetchClasses() async {
    final response = await FirebaseService().readClasses();
    if (response['success'] == true) {
      final data = response['data'];
      if (data.docs.isNotEmpty) {
        classes = data.docs.map<ClassModel>((doc) {
          return ClassModel.fromFireStore(doc.data(), doc.id);
        }).toList();
      } else {
        AppConstFunctions.customErrorMessage(message: 'No class found');
      }
    } else {
      AppConstFunctions.customErrorMessage(
          message: response['message'] ?? 'Something went wrong');
    }
    update(); // GetBuilder রিফ্রেশ করার জন্য
  }


  Future<bool> registerUser() async {
    _setLoading(true);
    final response = await FirebaseService().register(
      email: emailController.text,
      password: passwordController.text.trim(),
      name: nameController.text,
      schoolName: schoolNameController.text,
      className: selectedClass!,
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
