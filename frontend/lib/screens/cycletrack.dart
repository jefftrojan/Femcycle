import 'package:frontend/screens/logdates.dart';
import 'package:http/http.dart' as http;


import 'package:flutter/material.dart';
import 'package:frontend/screens/chatpy.dart';
import 'package:frontend/utils/utils.dart';
import 'dart:convert';

import '../utils/colors.dart';


class CyclePredictionScreen extends StatefulWidget {
  const CyclePredictionScreen({Key? key});

  @override
  State<CyclePredictionScreen> createState() => _CyclePredictionScreenState();
}

class _CyclePredictionScreenState extends State<CyclePredictionScreen> {
  DateTime _predictedDate = DateTime.now(); // Initialize with the current date

  @override
  void initState() {
    super.initState();
    _fetchPredictedDate(); // Fetch the predicted date when the screen loads.
  }

  Future<void> _fetchPredictedDate() async {
    final apiUrl = "http://127.0.0.1:5000/predict"; 
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String predictedDateStr = data['predicted_date'];
      setState(() {
        _predictedDate = DateTime.parse(predictedDateStr);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove elevation/shadow
        leading: Container(
          width: 100,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomNavScreen()));
            },
          ),
        ),
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Welcome Back",
            textScaleFactor: 1.5,
            style: TextStyle(color: Colors.black, fontFamily: 'Inter'),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(8),
                  height: 60,
                  decoration: BoxDecoration(
                    color: primaryDark,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Your Period is likely to start on or around ${_predictedDate.toLocal()}",
                        textScaleFactor: 1.1,
                        style: const TextStyle(
                          color: Color(0xFF090A0A),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                PredictedCalendar(loggedDate: _predictedDate), // Pass _predictedDate
                const SizedBox(height: 40),
                const Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "What Would you Like To Do?",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Color(0xFF090A0A),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        child: Text("Log Period"),
                        style: ElevatedButton.styleFrom(
                          primary: accentchatalt,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LogDates()));
                        },
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: accentchatalt,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: Text("Previous Periods"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Archive()));
                        },
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: accentchatalt,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: Text("Access Chat"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatScreen()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Archive extends StatelessWidget {
  const Archive({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
