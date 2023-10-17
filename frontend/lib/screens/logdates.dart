import 'package:frontend/utils/utils.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _loggedDate = DateTime.now(); // Initialize with the current date
  DateTime _predictedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Fetch the predicted date when the widget loads
    _fetchPredictedDate(_loggedDate);
  }

  Future<void> _fetchPredictedDate(DateTime selectedDate) async {
    final apiUrl = "http://127.0.0.1:5000/predict";
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"selected_date": selectedDate.toIso8601String()}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String predictedDateStr = data['predicted_date'];
      setState(() {
        _predictedDate = DateTime.parse(predictedDateStr);
      });
    } else {
      print('Failed to fetch prediction');
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    final DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    return Column(
      children: <Widget>[
        TableCalendar(
          calendarFormat: CalendarFormat.month,
          firstDay: firstDayOfMonth,
          lastDay: lastDayOfMonth,
          onDaySelected: (selectedDate, focusedDate) {
            setState(() {
              _loggedDate = selectedDate;
            });
            _fetchPredictedDate(selectedDate);
          },
          focusedDay: DateTime.now(),
        ),
        SizedBox(height: 20),
        Text(
          "Logged Date: ${_loggedDate.toLocal()}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          "Predicted Period Date: ${_predictedDate.toLocal()}",
        ),
      ],
    );
  }
}

class LogDates extends StatefulWidget {
  const LogDates({super.key});

  @override
  State<LogDates> createState() => _LogDatesState();
}

class _LogDatesState extends State<LogDates> {
  DateTime _loggedDate = DateTime.now(); // Initialize with the current date
  DateTime _predictedDate = DateTime.now();

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
          alignment: Alignment.center,
          child: Text(
            "Log Periods",
            textScaleFactor: 1.0,
            style: TextStyle(color: Colors.black, fontFamily: 'Inter'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CalendarWidget(),
              SizedBox(
                height: 40,
              ),
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
                      "Your next Period is on or around ${_predictedDate.toLocal()} ",
                      // textScaleFactor: 1.0,
                      style: const TextStyle(
                        color: Color(0xFF090A0A),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ListTile(
                leading: Icon(Icons.punch_clock),
                title: Text("Period Started on $_predictedDate"),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(Icons.timelapse),
                title: Text(
                    "Cycle length: ${_predictedDate.difference(_loggedDate)}"),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
