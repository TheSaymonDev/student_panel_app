import 'package:get/get.dart';
import 'package:student_panel/screens/explore_screen/models/topic_model.dart';
import 'package:student_panel/services/firebase_service.dart';
import 'package:student_panel/utils/app_const_functions.dart';

class QuestionController extends GetxController {
  bool isLoading = false;
  TopicModel? topicData;

  // Future<bool> fetchQuestions() async {
  //   _setLoading(true);
  //
  //   final response = await FirebaseService().fetchQuestion(topicId: '9kTvjlBWVlj3XjaCKRGv');
  //
  //   _setLoading(false);
  //
  //   if (response['success'] == true) {
  //     final docSnapshot = response['docSnapShot'];
  //     // Parse Firestore data
  //     if (docSnapshot.exists) {
  //       final data = docSnapshot.data() as Map<String, dynamic>;
  //       topicData = TopicModel.fromJson(data);
  //       AppConstFunctions.customSuccessMessage(message: 'Questions fetched successfully.');
  //       return true;
  //     } else {
  //       AppConstFunctions.customErrorMessage(message: 'No data found for this topic');
  //       return false;
  //     }
  //   } else {
  //     AppConstFunctions.customErrorMessage(
  //         message: response['message'] ?? 'Something went wrong');
  //     return false;
  //   }
  // }

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    //fetchQuestions();
  }
}
