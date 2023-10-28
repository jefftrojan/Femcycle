import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'brandkit/colors.dart';
import 'brandkit/textstylealt.dart';
import 'brandkit/utils.dart';
import 'model/cycletrack.model.dart';

class CycleTrackView {
  final CycleTrackModel model;

  CycleTrackView(this.model);

  DateTime get firstDayOfWeek {
    final today = model.today;
    final int dayOfWeek = today.weekday;
    final DateTime firstDay = today.subtract(Duration(days: dayOfWeek - 1));
    return firstDay;
  }

  DateTime get lastDayOfWeek {
    final firstDay = firstDayOfWeek;
    final DateTime lastDay = firstDay.add(Duration(days: 6));
    return lastDay;
  }

  void _onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    // Handle the day selection logic here
  }

  Widget build(BuildContext context) {
    String currentUsername = model.currentUsername;
    DateTime today = model.today;

    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffffffff),
                Color(0xffd1bed5),
              ],
              stops: [0.25, 0.75],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              TopBarFb2(
                title: 'Welcome back',
                upperTitle: 'Your Upper Title',
                currentUsername: currentUsername,
              ),
              SizedBox(height: 10,),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TableCalendar(
                    focusedDay: today,
                    firstDay: DateTime.utc(2023, 6, 10),
                    lastDay: DateTime.utc(2030, 6, 10),
                    locale: "en_US",
                    rowHeight: 45,
                    headerStyle: HeaderStyle(formatButtonVisible: false),
                    onDaySelected: _onDaySelected,
                    availableGestures: AvailableGestures.all,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 100,
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Color(0xffd1bed5),
                  child: Center(
                    child: ListTile(
                      subtitle: Text(
                        'Your period is predicted to come on or around ...',
                        style: TextStyle(
                          fontSize: 14,
                          color: black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Last Menstrual Cycle",
                    style: TextStyle(
                      fontSize: TitleStyle.fontSize,
                      fontFamily: TitleStyle.fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                    textScaleFactor: 0.8,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Card(
                        elevation: 8,
                        color: Color(0xffd1bed5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          color: Color(0xffd1bed5),
                          child: ListTile(
                            title: Text(
                              'Started on:',
                              style: TextStyle(),
                            ),
                            leading: Icon(Icons.timelapse_rounded, color: Colors.white),
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Card(
                        elevation: 8,
                        color: Color(0xffd1bed5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          color: Color(0xffd1bed5),
                          child: ListTile(
                            title: Text(
                              'Cycle Length:',
                              style: TextStyle(),
                            ),
                            leading: Icon(Icons.timelapse_rounded, color: Colors.white),
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class PeriodsView extends StatefulWidget {
  final PeriodsModel model;
  PeriodsView(this.model); 

  // PeriodsView(this.model, {required PeriodsModel othermodel});

  @override
  _PeriodsViewState createState() => _PeriodsViewState();
}

class _PeriodsViewState extends State<PeriodsView> {
  late DateTime firstDayOfWeek;
  late DateTime lastDayOfWeek;

  @override
  void initState() {
    super.initState();
    calculateWeekBoundaries(); // Initialize week boundaries
  }

  void calculateWeekBoundaries() {
    final today = widget.model.today;
    final int dayOfWeek = today.weekday;
    firstDayOfWeek = today.subtract(Duration(days: dayOfWeek - 1));
    lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));
  }

  @override
  Widget build(BuildContext context) {
    String currentUsername = widget.model.currentUsername;
    DateTime today = widget.model.today;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Color.fromARGB(97, 209, 190, 213),
            child: Column(
              children: [
                TopBarFb2(
                  title: 'Welcome back',
                  upperTitle: 'Your Upper Title',
                  currentUsername: currentUsername,
                ),
                SizedBox(height: 15,),
                TableCalendar(
                  focusedDay: today,
                  firstDay: firstDayOfWeek,
                  lastDay: lastDayOfWeek,
                  calendarFormat: CalendarFormat.week,
                  availableCalendarFormats: const {
                    CalendarFormat.week: 'Week',
                  },
                  headerStyle: HeaderStyle(formatButtonVisible: true),
                  daysOfWeekHeight: 0,
                  availableGestures: AvailableGestures.none,
                  onPageChanged: (focusedDay) {
                    if (focusedDay.isBefore(firstDayOfWeek) ||
                        focusedDay.isAfter(lastDayOfWeek)) {
                      calculateWeekBoundaries(); // Recalculate week boundaries
                    }
                  },
                ),
                SizedBox(height: 15,),
                Card(
                  elevation: 8.0,
                  color: Color.fromARGB(255, 213, 206, 214),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    height: 50,
                    width: 350,
                    child: Column(
                      children: [
                        Center(child: Text("Your period is likely to start on or around November 26th"))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 50,),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "What Would You like To Do?",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30,),
                            Center(child: HorizontalTiles())
                          ],
                        ),
                      ),
                    ),
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
