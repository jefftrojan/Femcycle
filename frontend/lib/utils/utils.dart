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

