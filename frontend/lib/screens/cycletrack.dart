import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/utils.dart';
import 'package:intl/intl.dart';

class Periods extends StatelessWidget {
  final List<DateTime> forecastedDates; // Add this variable to store predicted dates

  Periods({Key? key, required this.forecastedDates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Welcome Back",
          textScaleFactor: 1.5,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            // Display the predicted period start date
            Padding(
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
                    "Your period is likely to start on or around ${DateFormat('MMMM d, y').format(forecastedDates.first)}",
                    style: TextStyle(color: textsec),
                    textAlign: TextAlign.start,
                    textScaleFactor: 1.2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            // Display the month for the predicted dates
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.calendar_today),
                ),
                Text(
                  DateFormat('MMMM y').format(forecastedDates.first),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            // Display the predicted dates based on the forecastedDates list
            Row(
              children: List.generate(forecastedDates.length, (index) {
                final date = forecastedDates[index];
                final dayOfWeek = date.weekday;
                final dayOfMonth = date.day;
                final formattedDate = DateFormat('d').format(date);
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: dayOfWeek == DateTime.saturday || dayOfWeek == DateTime.sunday
                            ? Colors.grey[300]
                            : primarylight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Day $dayOfMonth',
                            style: TextStyle(
                              color: textsec,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              color: textsec,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 40),

            // Your existing widgets here...
            // ... (the code you provided in the previous messages)
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 0, onItemTapped: (int value) {}),
    );
  }
}
