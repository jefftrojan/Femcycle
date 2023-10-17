// import 'package:frontend/utils/utils.dart';
// import 'package:http/http.dart' as http;

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:flutter/material.dart';

// import '../utils/colors.dart';

// class CalendarWidget extends StatefulWidget {
//   @override
//   _CalendarWidgetState createState() => _CalendarWidgetState();
// }

// class _CalendarWidgetState extends State<CalendarWidget> {
//   DateTime _loggedDate = DateTime.now(); // Initialize with the current date
//   DateTime _predictedDate = DateTime.now();

//   @override
//   void initState() {
//     super.initState();
//     // Fetch the predicted date when the widget loads
//     _fetchPredictedDate(_loggedDate);
//   }

//   Future<void> _fetchPredictedDate(DateTime selectedDate) async {
//     final apiUrl = "http://127.0.0.1:5000/predict";
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({"selected_date": selectedDate.toIso8601String()}),
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       final String predictedDateStr = data['predicted_date'];
//       setState(() {
//         _predictedDate = DateTime.parse(predictedDateStr);
//       });
//     } else {
//       print('Failed to fetch prediction');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final DateTime now = DateTime.now();
//     final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
//     final DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

//     return Column(
//       children: <Widget>[
//         TableCalendar(
//           calendarFormat: CalendarFormat.month,
//           firstDay: firstDayOfMonth,
//           lastDay: lastDayOfMonth,
//           onDaySelected: (selectedDate, focusedDate) {
//             setState(() {
//               _loggedDate = selectedDate;
//             });
//             _fetchPredictedDate(selectedDate);
//           },
//           focusedDay: DateTime.now(),
//         ),
//         SizedBox(height: 20),
//         Text(
//           "Logged Date: ${_loggedDate.toLocal()}",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 20),
//         Text(
//           "Predicted Period Date: ${_predictedDate.toLocal()}",
//         ),
//       ],
//     );
//   }
// }

// class LogDates extends StatefulWidget {
//   const LogDates({super.key});

//   @override
//   State<LogDates> createState() => _LogDatesState();
// }

// class _LogDatesState extends State<LogDates> {
//   DateTime _loggedDate = DateTime.now(); // Initialize with the current date
//   DateTime _predictedDate = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0, // Remove elevation/shadow
//         leading: Container(
//           width: 100,
//           child: IconButton(
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => BottomNavScreen()));
//             },
//           ),
//         ),
//         title: const Align(
//           alignment: Alignment.center,
//           child: Text(
//             "Log Periods",
//             textScaleFactor: 1.0,
//             style: TextStyle(color: Colors.black, fontFamily: 'Inter'),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             children: [
//               CalendarWidget(),
//               SizedBox(
//                 height: 40,
//               ),
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 height: 60,
//                 decoration: BoxDecoration(
//                   color: primaryDark,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   children: [
//                     Text(
//                       "Your next Period is on or around ${_predictedDate.toLocal()} ",
//                       // textScaleFactor: 1.0,
//                       style: const TextStyle(
//                         color: Color(0xFF090A0A),
//                         fontSize: 14,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w600,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               ListTile(
//                 leading: Icon(Icons.punch_clock),
//                 title: Text("Period Started on $_predictedDate"),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               ListTile(
//                 leading: Icon(Icons.timelapse),
//                 title: Text(
//                     "Cycle length: ${_predictedDate.difference(_loggedDate)}"),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:frontend/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import '../utils/colors.dart';
import 'package:intl/intl.dart';

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
        // Text(
        //   "Predicted Period Date: ${_predictedDate.toLocal()}",
        // ),
      ],
    );
  }
}

class LogDates extends StatefulWidget {
  const LogDates({Key? key});

  @override
  State<LogDates> createState() => _LogDatesState();
}

class _LogDatesState extends State<LogDates> {
  DateTime _loggedDate = DateTime.now(); // Initialize with the current date
  DateTime _predictedDate = DateTime.now();

  CollectionReference periodsCollection = FirebaseFirestore.instance
      .collection('PeriodsPrev'); // Firestore collection

  Future<void> _storeLoggedDate(DateTime date) async {
    // Store the logged date in Firestore
    await periodsCollection.add({'loggedDate': date});

    // Update the UI
    setState(() {
      _loggedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
            textScaleFactor: 1.1,
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
                    Flexible(
                      child: Text(
                        "Your Period is likely to start on or around ${_predictedDate.toLocal()} ",
                        textScaleFactor: 1.1,
                        style: const TextStyle(
                          color: Color(0xFF090A0A),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
              ElevatedButton(
                onPressed: () {
                  _storeLoggedDate(DateTime.now());
                },
                child: Text('Log Current Date'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoggedPeriodsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('PeriodsPrev')
          .orderBy('loggedDate', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        final periods = snapshot.data!.docs;

        return ListView.builder(
          itemCount: periods.length,
          itemBuilder: (context, index) {
            final period = periods[index];
            final loggedDate = period['loggedDate'] as Timestamp;
            final monthInitial = String.fromCharCode(loggedDate.toDate().month);
            final formattedDate =
                DateFormat('MMMM yyyy').format(loggedDate.toDate());

            return ListTile(
              leading: CircleAvatar(
                child: Text(monthInitial, style: TextStyle(fontSize: 18)),
              ),
              title: Text('Period on $formattedDate'),
              subtitle: Text(
                  'Cycle length: ${calculateCycleLength(index, periods)} days'),
            );
          },
        );
      },
    );
  }

  int calculateCycleLength(int index, List<QueryDocumentSnapshot> periods) {
    if (index == 0) {
      return 0; // No cycle length for the first entry
    }

    final currentLoggedDate = periods[index]['loggedDate'] as Timestamp;
    final previousLoggedDate = periods[index - 1]['loggedDate'] as Timestamp;

    final difference =
        currentLoggedDate.toDate().difference(previousLoggedDate.toDate());

    return difference.inDays;
  }
}
