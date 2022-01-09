import 'package:flutter/material.dart';
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
          children: const [
            Text(
              kAppTitle,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 8),
            RoutingButton(route: kLoginScreen, buttonText: kLoginScreenText),
            SizedBox(height: 8),
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
