import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_panel/my_app.dart';
import 'package:student_panel/routes/app_routes.dart';
import 'package:student_panel/services/connectivity_service.dart';
import 'package:student_panel/services/shared_preference_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  await SharedPreferencesService().init(); // Initialize SharedPreferences
  final hasInternet = await ConnectivityService.isConnected();
  final userId = SharedPreferencesService().getUserId();
  final classId = SharedPreferencesService().getClassId();
  runApp(
    MyApp(
      initialRoute: hasInternet
          ? (userId.isNotEmpty && classId.isNotEmpty ? AppRoutes.homeScreen : AppRoutes.authScreen)
          : AppRoutes.noInternetScreen,
    ),
  );
}
