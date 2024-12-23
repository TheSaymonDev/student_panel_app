import 'package:get/get.dart';

class BottomNavController extends GetxController{
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void changeScreen(value){
    _selectedIndex=value;
    update();
  }
}