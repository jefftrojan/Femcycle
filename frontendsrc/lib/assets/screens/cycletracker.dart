import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontendsrc/brandkit/colors.dart';
import 'package:frontendsrc/brandkit/textstylealt.dart';
import 'package:frontendsrc/brandkit/utils.dart';
import 'package:table_calendar/table_calendar.dart';


// log periods
class CycleTrackmain extends StatefulWidget {
  const CycleTrackmain({Key? key}) : super(key: key);

  @override
  State<CycleTrackmain> createState() => _CycleTrackmainState();
}

class _CycleTrackmainState extends State<CycleTrackmain> {
  String currentUsername = '';
int daysToAdd = 30;

  @override
  void initState() {
    super.initState();
    // Initialize currentUsername with the user's display name
    fetchCurrentUsername();
  }

  Future<void> fetchCurrentUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUsername = user.displayName ?? ''; // Display name or an empty string if not available
      });
    }
  }

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffffffff),
                Color(0xffd1bed5),
                // Color(0xffcfb4cf),
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
                currentUsername: currentUsername, // Pass the current username
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
                  color:Color(0xffd1bed5),

                  child: Center(
                    child: ListTile(
                      subtitle: Text(
                        'Your period is predicted to come on or around ...',
                        style: TextStyle(
                          // fontFamily: SubtitleStyle.fontFamily,
                          fontSize: 14,
                          // fontWeight: FontWeight.w600,
                          color: black
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
                              style: TextStyle(
                                // fontSize: SubtitleStyle.fontSize,
                                // fontFamily: SubtitleStyle.fontFamily,
                                // fontWeight: FontWeight.w400,
                              ),
                            ),
                            // subtitle: Text('This is the first list tile.'),
                            leading: Icon(Icons.timelapse_rounded, color:Colors.white),
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
                          color:Color(0xffd1bed5) ,
                          
                          child: ListTile(
                            title: Text(
                              'Cycle Length:',
                              style: TextStyle(
                                // fontSize: SubtitleStyle.fontSize,
                                // fontFamily: SubtitleStyle.fontFamily,
                                // fontWeight: FontWeight.w400,
                              ),
                            ),
                            // subtitle: Text('This is the first list tile.'),
                            leading: Icon(Icons.timelapse_rounded, color: Colors.white,),
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
      // bottomNavigationBar: (),
      // bottomNavigationBar: 
    );
  }
}

// main periods


class Periodsmain extends StatefulWidget {
  const Periodsmain({Key? key}) : super(key: key);

  @override
  _PeriodsmainState createState() => _PeriodsmainState();
}

class _PeriodsmainState extends State<Periodsmain> {
  DateTime today = DateTime.now();
  DateTime firstDayOfWeek = DateTime.now();
  DateTime lastDayOfWeek = DateTime.now().add(Duration(days: 6));
  String currentUsername = '';

  @override
  void initState() {
    super.initState();
    // Initialize currentUsername with the user's display name
    fetchCurrentUsername();
  }

  Future<void> fetchCurrentUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUsername = user.displayName ?? ''; // Display name or an empty string if not available
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color:Color.fromARGB(97, 209, 190, 213) ,

            child: Column(
          
              children: [
                TopBarFb2(
                    title: 'Welcome back',
                    upperTitle: 'Your Upper Title',
                    currentUsername: currentUsername, // Pass the current username
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
                  headerStyle: HeaderStyle(
                    formatButtonVisible: true,
                  ),
                  daysOfWeekHeight: 0, // Hide days of the week
                  availableGestures: AvailableGestures.none, // Disable swipe gestures
                  onPageChanged: (focusedDay) {
                    // Prevent calendar from changing month
                    if (focusedDay.isBefore(firstDayOfWeek) ||
                        focusedDay.isAfter(lastDayOfWeek)) {
                      setState(() {
                        today = firstDayOfWeek;
                      });
                    }
                  },
                  
                ),
                SizedBox(height: 15,),
                Card(
                  elevation: 8.0,
                  color:  Color.fromARGB(255, 213, 206, 214),

                  child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  height: 50,
                  width: 350,
                  child:  Column(
                    children: [
                      Center(child: Text("Your period is likely to start on or around September 10th"))
                    ],            
                  ),

                ),),
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
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "What Would You like To Do",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30,),
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
      bottomNavigationBar: BottomNavBarFb3(),
    );
    
  }
}