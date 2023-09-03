import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/chat.dart';
import 'package:frontend/screens/onboarding.dart';
import 'package:frontend/screens/signup.dart';
import 'package:frontend/utils/utils.dart';

import '../utils/colors.dart';

class SplashScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 6000, // Adjust the duration as needed
      
      splash: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: Text(
                  'FemCycle',
                  style: TextStyle(
                    color: primary,
                    fontSize: 28,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      nextScreen:ChatAssistantScreen(user: User(name: "", email: ""),) , // Navigate to your main screen
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white, // Background color for the next screen
    );
  }
}
