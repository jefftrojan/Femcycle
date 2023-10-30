import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/symptoms.model.dart';

class SymptomController {
  SymptomData symptomData = SymptomData();

  void updateSymptomData(SymptomData newData) {
    symptomData = newData;
  }

  Future<void> addSymptomData(SymptomData data) async {
    try {
      await FirebaseFirestore.instance.collection('symptoms').add({
        'title': data.title,
        'text': data.text,
        'rangeValue': data.rangeValue,
        'selectedButtons': data.selectedButtons,
        'isBreastsTender': data.isBreastsTender,
        'isBreastsSore': data.isBreastsSore,
        'abdomenState': data.abdomenState,
        'timestamp': FieldValue.serverTimestamp(), // Add a timestamp
      });
    } catch (e) {
      print('Error adding symptom data: $e');
    }
  }
}