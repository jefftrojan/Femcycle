import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/signin.dart';
import 'package:frontend/utils/colors.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:frontend/utils/utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: _controller,
              itemCount: onboardingData.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentIndex = page;
                });
              },
              itemBuilder: (context, index) {
                return OnboardingStep(
                  content: onboardingData[index],
                );
              },
            ),
          ),
          DotsIndicator(
            dotsCount: onboardingData.length,
            position: _currentIndex,
            decorator: DotsDecorator(
              color: common,
              activeColor: black,
              size: const Size.square(8.0),
              activeSize: const Size(20, 8),
              spacing: const EdgeInsets.all(4.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(primaryDark),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
              child: Text(
                "Get Started",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
              );
            },
            child: Text(
              "Skip",
              style: TextStyle(color: Color.fromRGBO(65, 36, 92, 1)),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class OnboardingStep extends StatelessWidget {
  final OnboardingContent content;

  OnboardingStep({required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(content.image),
          SizedBox(
            height: 20,
          ),
          Text(
            content.title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            content.description,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}