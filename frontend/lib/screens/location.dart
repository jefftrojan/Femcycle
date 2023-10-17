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
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          "Store Locator",
          style: TextStyle(color: Colors.black),
        ),
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
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const TextField(
            decoration: InputDecoration(
                hintText: "Enter your location",
                icon: Icon(Icons.search),
                border: InputBorder.none,
                fillColor: primaryDark),
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
          steps: const [
            Step(
              title: Icon(Icons.directions_walk),
              content: Text('Choose to walk to the store'),
              isActive: true,
              state: StepState.editing,
            ),
            Step(
              title: Icon(Icons.directions_car),
              content: Text('Choose to drive to the store'),
              state: StepState.editing,
            ),
            Step(
              title: Icon(Icons.directions_bike),
              content: Text('Choose to bike to the store'),
              state: StepState.editing,
            ),
            Step(
              title: Icon(Icons.directions_transit),
              content: Text('Choose to take the train to the store'),
              state: StepState.editing,
            ),
          ],
        ),
        Expanded(
          child: ListView(
            children: [
              StoreCard("This feature is coming soon!"),
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
