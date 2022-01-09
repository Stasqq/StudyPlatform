import 'package:flutter/material.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/presentation/screens/class/class_content_preview_screen.dart';
import 'package:study_platform/presentation/screens/class/class_edit_screen.dart';
import 'package:study_platform/presentation/screens/class/class_screen.dart';
import 'package:study_platform/presentation/screens/course/chat_screen.dart';
import 'package:study_platform/presentation/screens/course/course_screen.dart';
import 'package:study_platform/presentation/screens/course/courses_screen.dart';
import 'package:study_platform/presentation/screens/course/create_course_screen.dart';
import 'package:study_platform/presentation/screens/general/login_screen.dart';
import 'package:study_platform/presentation/screens/general/signup_screen.dart';
import 'package:study_platform/presentation/screens/general/splash_screen.dart';
import 'package:study_platform/presentation/screens/general/user_info_screen.dart';
import 'package:study_platform/presentation/screens/general/welcome_screen.dart';
import 'package:study_platform/presentation/screens/test/create_question_screen.dart';
import 'package:study_platform/presentation/screens/test/create_test_screen.dart';
import 'package:study_platform/presentation/screens/test/test_result_screen.dart';
import 'package:study_platform/presentation/screens/test/test_screen.dart';
import 'package:study_platform/presentation/screens/test/tests_screen.dart';

import '../screens/class/class_content_edit_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case kSplashScreen:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case kWelcomeScreen:
        return MaterialPageRoute(
          builder: (_) => WelcomeScreen(),
        );
      case kLoginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case kSignupScreen:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
        );
      case kUserInfoScreen:
        return MaterialPageRoute(
          builder: (_) => UserInfoScreen(),
        );
      case kCoursesScreen:
        return MaterialPageRoute(
          builder: (_) => CoursesScreen(),
        );
      case kCreateCourseScreen:
        return MaterialPageRoute(
          builder: (_) => CreateCourseScreen(),
        );
      case kCourseScreen:
        return MaterialPageRoute(
          builder: (_) => CourseScreen(),
        );
      case kChatScreen:
        return MaterialPageRoute(
          builder: (_) => ChatScreen(),
        );
      case kClassEditScreen:
        return MaterialPageRoute(
          builder: (_) => ClassEditScreen(),
        );
      case kClassContentEditScreen:
        return MaterialPageRoute(
          builder: (_) => ClassContentEditScreen(),
        );
      case kClassContentPreviewScreen:
        return MaterialPageRoute(
          builder: (_) => ClassContentPreviewScreen(),
        );
      case kClassScreen:
        return MaterialPageRoute(
          builder: (_) => ClassScreen(),
        );
      case kCreateTestScreen:
        return MaterialPageRoute(
          builder: (_) => CreateTestScreen(),
        );
      case kCreateQuestionScreen:
        return MaterialPageRoute(
          builder: (_) => CreateQuestionScreen(),
        );
      case kTestsScreen:
        return MaterialPageRoute(
          builder: (_) => TestsScreen(),
        );
      case kTestScreen:
        return MaterialPageRoute(
          builder: (_) => TakingTestScreen(),
        );
      case kTestResultScreen:
        return MaterialPageRoute(
          builder: (_) => TestResultScreen(),
        );
      default:
        return null;
    }
  }
}
