import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontendsrc/assets/screens/chat.dart';
import 'package:frontendsrc/assets/screens/signin.dart';
import 'package:frontendsrc/brandkit/colors.dart';
import 'package:frontendsrc/firebase_options.dart';
import 'package:frontendsrc/view/locator.dart';
import 'package:frontendsrc/view/symptoms.view.dart';
import 'package:get/get.dart';
import 'controllers/cycletrack.controller.dart';
import 'periodsmain.view.dart';
import 'model/cycletrack.model.dart';
import 'brandkit/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  ); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String currentUsername = user != null ? user.displayName ?? 'Guest' : 'Guest';

    // Create an instance of CycleTrackModel
    CycleTrackModel cycleTrackModel = CycleTrackModel(
      currentUsername: currentUsername,
      today: DateTime.now(),
    );

    // Create an instance of PeriodsModel with default values
    PeriodsModel periodsModel = PeriodsModel(
      currentUsername: currentUsername,
      today: DateTime.now(),
      firstDayOfWeek: DateTime.now(), // Set the default value
      lastDayOfWeek: DateTime.now(),  // Set the default value
    );

    // Create an instance of CycleTrackController and provide the model
    CycleTrackController cycleTrackController = CycleTrackController(
      model: cycleTrackModel,
      view: CycleTrackView(cycleTrackModel, CycleTrackModel:CycleTrackModel ),
    );

    // Create an instance of PeriodsController and provide the model
    PeriodsController periodsController = PeriodsController(
      model: periodsModel,
      view: PeriodsView(periodsModel));

    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: primary,
        colorScheme: ColorScheme.light(primary: primary),
      ),
      debugShowCheckedModeBanner: false,
      title: '',
      home: SymptomForm(),
      // initialRoute: '/',
       routes: {
        '/home': (context) => PeriodsView(periodsModel), // Home main
        '/tracker': (context) => CycleTrackView( cycleTrackModel,CycleTrackModel: CycleTrackModel), //cycletracking
        '/chat': (context) => ChatScreen(),//chatscreen
        '/symptoms': (context) => SymptomForm(),//log symptom
        '/locator':(context) => Locator() //locate hospitals


      },
    );
  }
}
