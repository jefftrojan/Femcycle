import 'package:flutter/material.dart';
import 'package:frontendsrc/brandkit/colors.dart';
import 'package:frontendsrc/assets/screens/chat.dart';
import 'package:frontendsrc/assets/screens/cycletracker.dart';
import 'package:frontendsrc/assets/screens/locator.dart';
import 'package:frontendsrc/model/cycletrack.model.dart';
import 'package:frontendsrc/periodsmain.view.dart';
import 'package:get/get.dart';


class TopBarFb2 extends StatefulWidget {
  final String title;
  final String upperTitle;
  final String currentUsername;

  const TopBarFb2({
    required this.title,
    required this.upperTitle,
    required this.currentUsername,
    Key? key,
  }) : super(key: key);

  @override
  _TopBarFb2State createState() => _TopBarFb2State();
}

class _TopBarFb2State extends State<TopBarFb2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: GestureDetector(
                onTap: _openDrawer,
                child: CircleAvatar(
                  child: Icon(
                    Icons.account_circle,
                    size: 32,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.grey,
                ),
              ),
              title: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              subtitle: Text(
                widget.currentUsername,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
  
      ],
    );
  }
}



// bottomnav

class BottomNavBarFb3 extends StatelessWidget {
  const BottomNavBarFb3({Key? key}) : super(key: key);

  final primaryColor = primary;
  final secondaryColor = primaryDark;
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color(0xffd1bed5),
      child: SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBottomBar2(
                  text: "Home",
                  icon: Icons.home,
                  selected: true,
                  onPressed: () {}),
              Spacer(),
              IconBottomBar(
                  text: "Chat",
                  icon: Icons.chat_bubble,
                  selected: false,
                  onPressed: () {
                    
                  }),
              IconBottomBar(
                  text: "Periods",
                  icon: Icons.date_range_outlined,
                  selected: false,
                  onPressed: () {
                    //   Navigator.push(
                    // context,
                    // MaterialPageRoute(
                    //   builder: (context) {
                    //     // Create an instance of CycleTrackModel (if not created already)
                    //     // CycleTrackModel cycleTrackModel = CycleTrackModel(currentUsername: '', today: DateTime.now()); // Replace with actual model creation
                    //     // return CycleTrackView();
                    //   },
                    // ),
                 


                  }),
              IconBottomBar(
                  text: "Locator",
                  icon: Icons.location_pin,
                  selected: false,
                  onPressed: () {
                    // Get.off()
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  final primaryColor = primary;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? primaryColor : Colors.black54,
          ),
        ),
      ],
    );
  }
}

class IconBottomBar2 extends StatelessWidget {
  const IconBottomBar2(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  final primaryColor = primary;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: primaryColor,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}

// horizontal tiles----menu home
class HorizontalTiles extends StatefulWidget {
  @override
  _HorizontalTilesState createState() => _HorizontalTilesState();
}

class _HorizontalTilesState extends State<HorizontalTiles> {
  int activeTile = 0; // Store the index of the active tile

  // Define the tile data with their icons
  final List<Map<String, dynamic>> tiles = [
    {'icon': Icons.home, 'text': 'Home', 'route':"/home"},
    {'icon': Icons.date_range_outlined, 'text': 'Log Periods', 'route':'/tracker'},
    {'icon': Icons.list_alt_outlined, 'text': 'Hospitals Nearby', 'route':'/home'},
    {'icon': Icons.chat_bubble_outline_outlined, 'text': 'Access Chat', 'route':'/chat'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 2; i++) buildTile(i),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 2; i < 4; i++) buildTile(i),
          ],
        ),
      ],
    );
  }

  Widget buildTile(int index) {
    final isActive = activeTile == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          activeTile = index;
          Navigator.pushNamed(context, tiles[index]['route']);

        });
      },
      child: Container(
        width: 140, // Set the desired width
        height: 120, // Set the desired height
        margin: const EdgeInsets.all(8), // Set equal horizontal margin
        padding: const EdgeInsets.symmetric(horizontal: 8), // Set equal horizontal padding
        decoration: BoxDecoration(
          color: isActive ? primary : Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content
          children: [
            Icon(tiles[index]['icon'], size: 48, color: Colors.white),
            Text(
              tiles[index]['text'],
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
