import 'package:get/get.dart';
import 'package:student_panel/routes/app_routes.dart';
import 'package:student_panel/screens/auth_screen/auth_screen.dart';
import 'package:student_panel/screens/email_verification_screen/bindings/email_verification_binding.dart';
import 'package:student_panel/screens/email_verification_screen/email_verification_screen.dart';
import 'package:student_panel/screens/exam_screen/bindings/exam_binding.dart';
import 'package:student_panel/screens/exam_screen/exam_screen.dart';
import 'package:student_panel/screens/explore_screen/bindings/explore_binding.dart';
import 'package:student_panel/screens/home_screen/bindings/home_binding.dart';
import 'package:student_panel/screens/home_screen/home_screen.dart';
import 'package:student_panel/screens/log_in_screen/bindings/log_in_binding.dart';
import 'package:student_panel/screens/log_in_screen/log_in_screen.dart';
import 'package:student_panel/screens/quiz_list_screen/bindings/quiz_list_binding.dart';
import 'package:student_panel/screens/quiz_list_screen/quiz_list_screen.dart';
import 'package:student_panel/screens/registration_screen/bindings/registration_binding.dart';
import 'package:student_panel/screens/registration_screen/registration_screen.dart';
import 'package:student_panel/screens/reset_password_screen/bindings/reset_password_binding.dart';
import 'package:student_panel/screens/reset_password_screen/reset_password_screen.dart';
import 'package:student_panel/screens/result_history_screen/bindings/result_history_binding.dart';
import 'package:student_panel/screens/result_history_screen/result_history_screen.dart';
import 'package:student_panel/screens/result_screen/bindings/result_binding.dart';
import 'package:student_panel/screens/result_screen/result_screen.dart';
import 'package:student_panel/screens/subject_list_screen/bindings/subject_list_binding.dart';
import 'package:student_panel/screens/subject_list_screen/subject_list_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.authScreen,
      page: () => AuthScreen(),
    ),
    GetPage(
      name: AppRoutes.logInScreen,
      page: () => LogInScreen(),
      binding: LogInBinding(),
    ),
    GetPage(
      name: AppRoutes.registrationScreen,
      page: () => RegistrationScreen(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: AppRoutes.emailVerificationScreen,
      page: () => EmailVerificationScreen(),
      binding: EmailVerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPasswordScreen,
      page: () => ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => HomeScreen(),
      bindings: [
        HomeBinding(),
        ExploreBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.subjectListScreen,
      page: () => SubjectListScreen(),
      binding: SubjectListBinding(),
    ),
    GetPage(
      name: AppRoutes.quizListScreen,
      page: () => QuizListScreen(),
      binding: QuizListBinding(),
    ),
    GetPage(
      name: AppRoutes.examScreen,
      page: () => ExamScreen(),
      binding: ExamBinding(),
    ),
    GetPage(
      name: AppRoutes.resultScreen,
      page: () => ResultScreen(),
      binding: ResultBinding(),
    ),
    GetPage(
      name: AppRoutes.resultHistoryScreen,
      page: () => ResultHistoryScreen(),
      binding: ResultHistoryBinding(),
    )
  ];
}
