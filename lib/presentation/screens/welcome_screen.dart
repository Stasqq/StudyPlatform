import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_platform/constants/colors.dart';
import 'package:study_platform/constants/string_variables.dart';

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
      // jak ci sie style powtarzaja to mozesz zrobic globalne
      // i tylko inlinowo je zmieniac jak potrzeba
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        primary: kButtonColor,
      ),
      onPressed: () => Navigator.of(context).pushNamed(route),
      child: Text(buttonText),
    );
  }
}
