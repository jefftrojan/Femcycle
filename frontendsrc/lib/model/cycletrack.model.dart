class CycleTrackModel {
  String currentUsername;
  DateTime today;

  CycleTrackModel({
    required this.currentUsername,
    required this.today,
  });
}

class PeriodsModel {
  String currentUsername;
  DateTime today;
  DateTime firstDayOfWeek;
  DateTime lastDayOfWeek;

  PeriodsModel({
    required this.currentUsername,
    required this.today,
    required this.firstDayOfWeek,
    required this.lastDayOfWeek,
  });
}
