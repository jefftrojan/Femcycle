import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/screens/chatpy.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/utils.dart';
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
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryDark,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Your Period is likely to start on or around $predictedDate",
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
                PredictedCalendar(predictedDate: DateTime(2023, 10, 20)),
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
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LogDates()));
                        },
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: accentchatalt,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        child: Text("Previous Periods"),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Archive()));
                        },
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: accentchatalt,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        child: Text("Access Chat"),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Archive extends StatefulWidget {
  const Archive({Key? key});

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class LogDates extends StatefulWidget {
  const LogDates({Key? key});

  @override
  State<LogDates> createState() => _LogDatesState();
}

class _LogDatesState extends State<LogDates> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime _lastcycleDate = DateTime(2023, 10, 20); // Change this to the last cycle date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Period Date'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime(2000),
                lastDay: DateTime(2050),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(day, _selectedDay);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(8),
                height: 40,
                decoration: BoxDecoration(
                  color: primaryDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      "Your Period is likely to start on or around ${_lastcycleDate.toLocal()}",
                      textScaleFactor: 1.1,
                      style: TextStyle(
                        color: Color(0xFF090A0A),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Last Menstrual Cycle",
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
              SizedBox(height: 40),
              Card(
                elevation: 4,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ListTile(
                        leading: Icon(Icons.punch_clock_outlined),
                        title: Text("Started on ${_lastcycleDate.toLocal()}"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Card(
                elevation: 4, 
              )
            ],
          ),
        ),
      ),
    );
  }
}
