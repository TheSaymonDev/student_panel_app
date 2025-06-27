import 'package:get/get.dart';
import 'package:student_panel/screens/result_history_screen/controllers/result_list_controller.dart';

class ResultHistoryBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ResultListController(),);
  }
}