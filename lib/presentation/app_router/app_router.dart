import 'package:flutter/material.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/data/models/course/course.dart';
import 'package:study_platform/presentation/screens/course_screen.dart';
import 'package:study_platform/presentation/screens/courses_screen.dart';
import 'package:study_platform/presentation/screens/create_course_screen.dart';
import 'package:study_platform/presentation/screens/profile_screen.dart';
import 'package:study_platform/presentation/screens/login_screen.dart';
import 'package:study_platform/presentation/screens/signup_screen.dart';
import 'package:study_platform/presentation/screens/splash_screen.dart';
import 'package:study_platform/presentation/screens/user_info_screen.dart';
import 'package:study_platform/presentation/screens/welcome_screen.dart';

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
      case kProfileScreen:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
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
          builder: (_) => CourseScreen(course: routeSettings.arguments as Course),
        );
      default:
        return null;
    }
  }
}
