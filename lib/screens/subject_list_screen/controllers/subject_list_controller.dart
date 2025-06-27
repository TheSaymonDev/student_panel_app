import 'package:get/get.dart';
import 'package:student_panel/screens/subject_list_screen/models/subject_model.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:student_panel/services/shared_preference_service.dart';
import 'package:student_panel/utils/app_const_functions.dart';


class SubjectListController extends GetxController {
  bool isLoading = false;
  List<SubjectModel> subjects = [];
  late String classId;

  Future<bool> _readSubjects({required String classId}) async {
    _setLoading(true);
    final response = await FirebaseService().readSubjects(classId: classId);
    _setLoading(false);
    if (response['success'] == true) {
      final data = response['data'];
      if (data.docs.isNotEmpty) {
        subjects = data.docs.map<SubjectModel>((doc) {
          return SubjectModel.fromFireStore(doc.data(), doc.id);
        }).toList();
        return true;
      } else {
        subjects = [];
        AppConstFunctions.customErrorMessage(message: 'No subject found');
        return false;
      }
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

  void refreshSubjects() {
    _readSubjects(classId: classId);
  }

  @override
  void onInit() {
    super.onInit();
    classId = SharedPreferencesService().getClassId();
    _readSubjects(classId: classId);
  }
}
