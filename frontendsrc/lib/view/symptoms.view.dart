import 'package:flutter/material.dart';
import 'package:frontendsrc/brandkit/textstylealt.dart';

import '../controllers/symptoms.controller.dart';
import '../model/symptoms.model.dart';



class SymptomForm extends StatefulWidget {
  @override
  _SymptomFormState createState() => _SymptomFormState();
}

class _SymptomFormState extends State<SymptomForm> {
  final SymptomController _symptomController = SymptomController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  double _rangeValue = 0.0;
  List<bool> _selectedButtons = List.generate(5, (index) => false);

  bool _isBreastsTender = false;
  bool _isBreastsSore = false;
  String _abdomenState = 'Normal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Wellness Check', style: TextStyle(fontSize: SubtitleStyle.fontSize),),
            TextField(controller: _titleController),
            Flexible(child: Text('We use the data you enter to better your period predictions')),
            SizedBox(height: 10,),
            TextField(controller: _textController),
            Text('Range Picker'),
            Slider(
              value: _rangeValue,
              onChanged: (newValue) {
                setState(() {
                  _rangeValue = newValue;
                });
              },
              min: 0.0,
              max: 5.0,
              divisions: 5,
            ),
            Text('Discharge Appearance'),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: _selectedButtons.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedButtons[index] = !_selectedButtons[index];
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        _selectedButtons[index] ? Colors.green : Colors.grey),
                  ),
                  child: Text('Button $index'),
                );
              },
            ),
            Text('Breasts'),
            Row(
              children: [
                Text('Tender'),
                Checkbox(
                  value: _isBreastsTender,
                  onChanged: (newValue) {
                    setState(() {
                      _isBreastsTender = newValue ?? false;
                    });
                  },
                ),
                Text('Sore'),
                Checkbox(
                  value: _isBreastsSore,
                  onChanged: (newValue) {
                    setState(() {
                      _isBreastsSore = newValue ?? false;
                    });
                  },
                ),
              ],
            ),
            Text('Abdomen'),
            DropdownButton<String>(
              value: _abdomenState,
              onChanged: (newValue) {
                setState(() {
                  _abdomenState = newValue ?? 'Normal';
                });
              },
              items: ['Normal', 'Bloated'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                
                
                final SymptomData symptomData = SymptomData(
                  title: _titleController.text,
                  text: _textController.text,
                  rangeValue: _rangeValue.toInt(),
                  // selectedButtons: selectedButtonsAsStrings,
                  isBreastsTender: _isBreastsTender,
                  isBreastsSore: _isBreastsSore,
                  abdomenState: _abdomenState,
                );
                _symptomController.addSymptomData(symptomData);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Wellness Check Done'),
                  ),
                );
                // Clear the form
                _titleController.clear();
                _textController.clear();
                setState(() {
                  _rangeValue = 0.0;
                  _selectedButtons = List.generate(5, (index) => false);
                  _isBreastsTender = false;
                  _isBreastsSore = false;
                  _abdomenState = 'Normal';
                });
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

