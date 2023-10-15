import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class UpdateDateFormOverlay extends StatefulWidget {
  const UpdateDateFormOverlay({Key? key}) : super(key: key);

  @override
  _UpdateDateFormOverlayState createState() => _UpdateDateFormOverlayState();
}

class _UpdateDateFormOverlayState extends State<UpdateDateFormOverlay> {
  final TextEditingController _dateController1 = TextEditingController();
  final TextEditingController _dateController2 = TextEditingController();
  final TextEditingController _dateController3 = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<DateTime> historicalDates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Entry Form'),
        backgroundColor: Colors.blue, // Custom background color for AppBar
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DateInputField(_dateController1, 'Date 1'),
                DateInputField(_dateController2, 'Date 2'),
                DateInputField(_dateController3, 'Date 3'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_areDatesValid()) {
        // Store the historicalDates in Firestore
        await FirebaseFirestore.instance.collection('previous_dates').add({
          'dates': historicalDates.map((date) => date.toIso8601String()).toList(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Dates submitted successfully'),
          ),
        );
        Navigator.of(context).pop(); // Close the overlay
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter at least two different months.'),
          ),
        );
      }
    }
  }

  bool _areDatesValid() {
    Set<String> uniqueMonths = Set();
    historicalDates.forEach((date) {
      uniqueMonths.add('${date.year}-${date.month}');
    });

    return uniqueMonths.length >= 2;
  }
}

class DateInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  DateInputField(this.controller, this.labelText);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a date.';
        }
        try {
          DateTime date = DateTime.parse(value);
          return null;
        } catch (e) {
          return 'Invalid date format. Use YYYY-MM-DD.';
        }
      },
    );
  }
}
