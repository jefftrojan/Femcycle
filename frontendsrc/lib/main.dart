import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontendsrc/brandkit/colors.dart';
import 'package:get/get.dart';
import 'controllers/cycletrack.controller.dart'; // Import your controllers and models
import 'periodsmain.view.dart';
import 'model/cycletrack.model.dart';
import 'assets/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase before running the app
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String currentUsername = user != null ? user.displayName ?? 'Guest' : 'Guest';

    // Create an instance of CycleTrackModel
    CycleTrackModel cycleTrackModel =
        CycleTrackModel(currentUsername: currentUsername, today: DateTime.now());

    // Now create an instance of CycleTrackController and provide the model
    CycleTrackController cycleTrackController = CycleTrackController(
      model: cycleTrackModel,
      view: CycleTrackView(cycleTrackModel), // Pass the model as an argument
    );

    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: primary,
        colorScheme: ColorScheme.light(primary: primary),
      ),
      debugShowCheckedModeBanner: false,
      title: '',
      home: SplashScreenWidget(),
    );
  }
}
