import 'package:flutter/material.dart';
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
          SizedBox(height: 30,),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(Icons.calendar_today),
              ),
              Text(
                'September 2023',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          Row(
            children: List.generate(7, (index) {
              final date = DateTime(2023, 9, 10).add(Duration(days: index));
              final dayOfWeek = date.weekday;
              final dayOfMonth = date.day;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color:
                          dayOfWeek == DateTime.saturday || dayOfWeek == DateTime.sunday
                              ? Colors.grey[300]
                              : primarylight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Day $dayOfMonth',
                        style:
                            TextStyle(color: textsec, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 40,),
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
          ),
          
        ],
      ),
      
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 0, onItemTapped: (int value) {  },),
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