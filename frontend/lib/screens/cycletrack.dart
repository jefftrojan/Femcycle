import 'package:flutter/material.dart';
import 'package:frontend/screens/chatpy.dart';
import 'package:frontend/screens/location.dart';
import 'package:frontend/screens/profile.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/utils.dart';

class Periods extends StatelessWidget {
  const Periods({super.key});

  // implement logic to pull prediction dates from logged data here.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // elevation: ,

        title: Text(
          "Welcome Back",
          textScaleFactor: 1.5,
          style: TextStyle(color: black, fontWeight: FontWeight.bold),
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