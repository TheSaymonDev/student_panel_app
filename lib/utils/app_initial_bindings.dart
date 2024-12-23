import 'package:get/get.dart';
import 'package:student_panel/localizations/language_controller.dart';
import 'package:student_panel/themes/theme_controller.dart';


class AppInitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(LanguageController());
  }
}
