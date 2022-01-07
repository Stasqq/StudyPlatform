import 'package:firebase_core/firebase_core.dart';
import 'package:study_platform/constants/string_variables.dart';

List<String> kInvisibleDrawerScreensTitles = [
  kLoginScreenText,
  kSignupScreenText,
  kWelcomeScreenText,
  kUserInfoScreenText
];

FirebaseOptions kWebFirebaseOptions = const FirebaseOptions(
  apiKey: "AIzaSyB0fZ_iUIr7qzyI9Ygek3TntbIX9Upf2YQ",
  authDomain: "study-platform-7be51.firebaseapp.com",
  projectId: "study-platform-7be51",
  storageBucket: "study-platform-7be51.appspot.com",
  messagingSenderId: "39464472146",
  appId: "1:39464472146:web:3f1c2deacd5a6d1da0598b",
  measurementId: "G-YT1FRMQYZ0",
);
