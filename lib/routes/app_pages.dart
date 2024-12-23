import 'package:get/get.dart';
import 'package:student_panel/routes/app_routes.dart';
import 'package:student_panel/screens/auth_screen/auth_screen.dart';
import 'package:student_panel/screens/email_verification_screen/bindings/email_verification_binding.dart';
import 'package:student_panel/screens/email_verification_screen/email_verification_screen.dart';
import 'package:student_panel/screens/explore_screen/bindings/explore_binding.dart';
import 'package:student_panel/screens/home_screen/bindings/home_binding.dart';
import 'package:student_panel/screens/home_screen/home_screen.dart';
import 'package:student_panel/screens/log_in_screen/bindings/log_in_binding.dart';
import 'package:student_panel/screens/log_in_screen/log_in_screen.dart';
import 'package:student_panel/screens/quiz_screen/bindings/quiz_binding.dart';
import 'package:student_panel/screens/quiz_screen/quiz_screen.dart';
import 'package:student_panel/screens/registration_screen/bindings/registration_binding.dart';
import 'package:student_panel/screens/registration_screen/registration_screen.dart';
import 'package:student_panel/screens/reset_password_screen/bindings/reset_password_binding.dart';
import 'package:student_panel/screens/reset_password_screen/reset_password_screen.dart';
import 'package:student_panel/screens/subject_list_screen/subject_list_screen.dart';
import 'package:student_panel/screens/topic_list_screen/topic_list_screen.dart';

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
    ),
    GetPage(
      name: AppRoutes.topicListScreen,
      page: () => TopicListScreen(),
    ),
    GetPage(
      name: AppRoutes.quizScreen,
      page: () => QuizScreen(),
      binding: QuizBinding(),
    )
  ];
}
