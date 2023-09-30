import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/screens/chatpy.dart';
import 'package:frontend/screens/cycletrack.dart';
import 'package:frontend/screens/location.dart';
import 'package:frontend/screens/profile.dart';
import 'package:frontend/screens/splash.dart';
import 'package:frontend/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  // Load and initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: Account(),
       
    );
  }
}
