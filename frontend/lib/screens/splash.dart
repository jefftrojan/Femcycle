import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/signin.dart';

import '../utils/colors.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({super.key});

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
              child: const Center(
                child: Text(
                  'FemCycle',
                  style: TextStyle(
                    color: primary,
                    fontSize: 28,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      nextScreen:const SignIn() , // Navigate to your main screen
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white, // Background color for the next screen
    );
  }
}
