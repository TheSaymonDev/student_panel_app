import 'package:get/get.dart';
import 'package:student_panel/localizations/translations/bn_bd_translations.dart';
import 'package:student_panel/localizations/translations/en_us_translations.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUs, 'bn_BD': bnBd};
}