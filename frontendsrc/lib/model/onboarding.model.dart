// models
import 'package:flutter/material.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Reproductive Health Resources at your fingertips",
    image: "lib/assets/femalecard.jpg",
    desc: "FemCycle chatbot will be available for you all day any day.",
  ),
  OnboardingContents(
    title: "Keep Track of your periods",
    image: "lib/assets/girlsclock.jpg",
    desc:
        "We use your previous dates to predict the next. We give you the power to remain prepared for your cycle.",
  ),
  OnboardingContents(
    title: "Locate Stores and Hospitals near you",
    image: "lib/assets/locationi.png",
    desc:
        "In need of sanitary products, or specialist hospitals? We’ll recommend affordable stores near you.",
  ),
];

// sizes

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenW;
  static double? screenH;
  static double? blockH;
  static double? blockV;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenW = _mediaQueryData!.size.width;
    screenH = _mediaQueryData!.size.height;
    blockH = screenW! / 100;
    blockV = screenH! / 100;
  }
}