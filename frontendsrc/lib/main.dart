import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontendsrc/brandkit/colors.dart';
import 'package:frontendsrc/brandkit/utils.dart';
import 'package:frontendsrc/firebase_options.dart';
import 'package:frontendsrc/screens/chat.dart';
import 'package:frontendsrc/screens/cycletracker.dart';
import 'package:frontendsrc/screens/locator.dart';
import 'package:frontendsrc/screens/onboarding.dart';
import 'package:frontendsrc/screens/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  // Load and initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primary,
        colorScheme: ColorScheme.light(primary: primary)

      ),
      debugShowCheckedModeBanner: false,
      title: '',
      home:Periodsmain(),
    );
  }
}
