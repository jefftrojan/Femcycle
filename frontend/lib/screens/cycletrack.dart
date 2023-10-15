import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/screens/chatpy.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/utils.dart';
import 'package:intl/intl.dart';

class Periods extends StatelessWidget {
  final List<DateTime> forecastedDates; // Add this variable to store predicted dates

  Periods({Key? key, required this.forecastedDates}) : super(key: key);

import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

class CyclePredictionScreen extends StatefulWidget {
  const CyclePredictionScreen({Key? key});

  @override
  State<CyclePredictionScreen> createState() => _CyclePredictionScreenState();
}

class _CyclePredictionScreenState extends State<CyclePredictionScreen> {
  String predictedDate = "";

  @override
  void initState() {
    super.initState();
    fetchPredictedDate(); // Fetch the predicted date when the screen loads.
  }

  Future<void> fetchPredictedDate() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/predict')); // Replace with your FastAPI server URL
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        predictedDate = data['forecasted_dates'];
      });
    } else {
      setState(() {
        predictedDate = 'Error fetching date';
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavScreen()));
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
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primarylight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Your period is likely to start on or around September 10th",
                        style: TextStyle(color: textsec),
                        textAlign: TextAlign.start,
                        textScaleFactor: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "What would you like to do?",
                  textScaleFactor: 1,
                  style: TextStyle(color: black, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(common)),

                  onPressed: () {
                    // log in to log your period form/screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> LogPeriod())
                    );
                  },
                  child: Text("Log Period")),
                   ElevatedButton(
                   style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(common)),

                   onPressed: () {
                    // log in to log your period form/screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> PrevPeriods())
                    );
                  },
                  child: Text("View Last Period")),
                   ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(common)),
                    onPressed: () {
                    // log in to log your period form/screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> BottomNavScreen())
                    );
                  },
                  child: Text("Access Chat")),
            ],
          )
        ],
      ),
    );
  }
}

class LogPeriod extends StatefulWidget {
  const LogPeriod({super.key});

  @override
  State<LogPeriod> createState() => _LogPeriodState();
}

class _LogPeriodState extends State<LogPeriod> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// viewing prev periods
class PrevPeriods extends StatefulWidget {
  const PrevPeriods({super.key});

  @override
  State<PrevPeriods> createState() => _PrevPeriodsState();
}

class _PrevPeriodsState extends State<PrevPeriods> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}