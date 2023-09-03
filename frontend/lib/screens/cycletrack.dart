import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:frontend/utils/colors.dart';
import 'package:table_calendar/table_calendar.dart';


class Periods extends StatefulWidget {
  const Periods({super.key});

  @override
  State<Periods> createState() => _PeriodsState();
}

class _PeriodsState extends State<Periods> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: primary,
        title: Text("Fem Cycle"),

      ),
      body: SingleChildScrollView(

      ),
    );
  }
}