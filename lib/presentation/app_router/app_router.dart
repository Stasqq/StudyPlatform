import 'package:flutter/material.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/presentation/screens/courses_screen.dart';
import 'package:study_platform/presentation/screens/create_course_screen.dart';
import 'package:study_platform/presentation/screens/home_screen.dart';
import 'package:study_platform/presentation/screens/login_screen.dart';
import 'package:study_platform/presentation/screens/signup_screen.dart';
import 'package:study_platform/presentation/screens/user_info_screen.dart';
import 'package:study_platform/presentation/screens/welcome_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
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
      case kHomeScreen:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
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
      default:
        return null;
    }
  }
}
