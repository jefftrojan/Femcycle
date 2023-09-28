import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/signin.dart';

import '../utils/colors.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 6000, 
      
      
      splash: Container(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: const Center(
                child: Text(
                  'Fem.Cycle',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      nextScreen:const SignIn() , // Navigate to your main screen
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: primaryDark, // Background color for the next screen
    );
  }
}


class Onboarding extends StatelessWidget {
  // implemenet onboarding screen with PageViewMOdel here
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}