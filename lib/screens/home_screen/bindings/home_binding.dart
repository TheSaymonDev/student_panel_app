import 'package:get/get.dart';
import 'package:student_panel/screens/home_screen/controllers/bottom_nav_controller.dart';

class HomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(BottomNavController());
  }
}