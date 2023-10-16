//this file contains the utils: bottomnav, custom buttons, onboarding content models.....

import 'package:flutter/material.dart';
import 'package:frontend/screens/chatpy.dart';
import 'package:frontend/screens/cycletrack.dart';
import 'package:frontend/screens/location.dart';
import 'package:frontend/screens/profile.dart';
import 'package:frontend/utils/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}
// calendar
class PredictedCalendar extends StatelessWidget {
  final DateTime predictedDate;

  PredictedCalendar({required this.predictedDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: predictedDate,
          firstDay: predictedDate.subtract(Duration(days: 30)),
          lastDay: predictedDate.add(Duration(days: 30)),
          calendarFormat: CalendarFormat.week,
          selectedDayPredicate: (day) {
            return isSameDay(day, predictedDate);
          },
          headerStyle: HeaderStyle(
            formatButtonShowsNext: false,
          ),
        ),
        SizedBox(height: 30,),
        Text(
        "Predicted Period Date: ${predictedDate.toLocal()}",

          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
// models --->onboarding screens content
class OnboardingContent {
  final String image;
  final String title;
  final String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnboardingContent> onboardingData = [
  OnboardingContent(
    image: "lib/assets/femalecard.jpg",
    title: "Reproductive Health Resources at your fingertips",
    description: "FemCycle chatbot will be available for you all day any day.",
  ),
  OnboardingContent(
    image: "lib/assets/locations.jpg",
    title: "Locate Stores near you",
    description:
        "In need of sanitary products, Let us know where you are, and we’ll recommend affordable stores near you.",
  ),
  OnboardingContent(
    image: "lib/assets/girlsclock.jpg",
    title: "Keep Track of your periods",
    description:
        "We use your previous dates to predict the next. We give you the power to remain prepared for your cycle.",
  ),
];

// custom appbar for chat



// custom bottomnav
class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.messenger_rounded,color: black,),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.water_drop,color: black,),
          label: 'Periods',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_pin,color: black,),
          
          label: 'Stores Nearby',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,color: black,),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor:primaryDark,
      showSelectedLabels: true,
      onTap: onItemTapped,
      unselectedItemColor: common,
    );
  }
}

// persistent bottom navbar
class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          ChatScreen(),
          CyclePredictionScreen(),
          Stores(),
          Account(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

