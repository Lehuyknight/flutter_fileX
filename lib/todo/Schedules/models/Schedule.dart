class Schedule {
  int? id;
  String? title;
  String? note;
  String? date;
  String? isDone;
  String? time;
  Schedule({
    this.id,
    required this.title,
    this.note,
    this.date,
    required this.isDone,
    required this.time,
  });

  // Getters
  int? get _id => id;
  String? get _title => title;
  String? get _note => note;
  String? get _date => date;
  String? get _isDone => isDone;
  String? get _time => time;

  // setters
  set _title(String? newTitle) {
    this.title = newTitle;
  }

  set _date(String? newdate) {
    this.date = newdate;
  }

  set _isDone(String? NewisDone) {
    this.isDone = NewisDone;
  }

  set _time(String? newDateTime) {
    this.time = newDateTime;
  }

  set _note(String? newNote) {
    this.note = newNote;
  }

  // Convert a Schedule object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['note'] = _note;
    map['date'] = _date;
    map['time'] = _time;
    map['isDone'] = _isDone;
    return map;
  }

  // Extract a Task object from a Map object
  Schedule.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.note = map['note'];
    this.date = map['date'];
    this.time = map['time'];
    this.isDone = map['isDone'];
  }
}
