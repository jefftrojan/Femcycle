// symptoms model
class SymptomData {
  String title;
  String text;
  int rangeValue;
  List<String> selectedButtons;
  bool isBreastsTender;
  bool isBreastsSore;
  String abdomenState;

  SymptomData({
    this.title = '',
    this.text = '',
    this.rangeValue = 0,
    this.selectedButtons = const [],
    this.isBreastsTender = false,
    this.isBreastsSore = false,
    this.abdomenState = '',
  });

  
}
