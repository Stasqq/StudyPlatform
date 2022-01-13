import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:study_platform/constants/colors.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/constants/styles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: kLogoTag,
              child: Image.asset(
                kEducationImage,
                color: darkPrimaryColor,
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(height: 20),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  kAppTitle,
                  textStyle: TextStyle(
                    color: darkPrimaryColor,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                  speed: const Duration(milliseconds: 200),
                ),
              ],
              totalRepeatCount: 1,
              displayFullTextOnTap: true,
            ),
            SizedBox(height: 20),
            RoutingButton(route: kLoginScreen, buttonText: kLoginScreenText),
            SizedBox(height: 10),
            RoutingButton(route: kSignupScreen, buttonText: kSignupScreenText),
          ],
        ),
      ),
    );
  }
}

class RoutingButton extends StatelessWidget {
  final String route;
  final String buttonText;

  const RoutingButton({Key? key, required this.route, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: kButtonStyle,
      onPressed: () => Navigator.of(context).pushNamed(route),
      child: Text(buttonText),
    );
  }
}
