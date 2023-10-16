import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

class Stores extends StatefulWidget {
  const Stores({super.key});

  @override
  State<Stores> createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text("Store Locator"),
      ),
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        // Search Bar (Rounded)
        Container(
          margin: EdgeInsets.all(16.0),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Enter your location",
              icon: Icon(Icons.search),
              border: InputBorder.none,
            ),
          ),
        ),
        // Transportation Options
        Stepper(
          currentStep: 0,
          onStepTapped: (step) {
            // Handle step tap
          },
          onStepContinue: () {
            // Handle continue button
          },
          onStepCancel: () {
            // Handle cancel button
          },
          steps: [
            Step(
              title: Icon(Icons.directions_walk),
              content: Text('Choose to walk to the store'),
            ),
            Step(
              title: Icon(Icons.directions_car),
              content: Text('Choose to drive to the store'),
            ),
            Step(
              title: Icon(Icons.directions_bike),
              content: Text('Choose to bike to the store'),
            ),
            Step(
              title: Icon(Icons.directions_transit),
              content: Text('Choose to take the train to the store'),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            children: [
              
              StoreCard("Store 1"),
              StoreCard("Store 2"),
              StoreCard("Store 3"),
            ],
          ),
        ),
      ],
    );
  }
}

class StoreCard extends StatelessWidget {
  final String storeName;

  StoreCard(this.storeName);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: ListTile(
        title: Text(storeName),
      ),
    );
  }
}
