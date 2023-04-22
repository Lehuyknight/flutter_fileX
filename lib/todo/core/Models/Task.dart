//defining Task as a Data Model to create objects
//Task is just a class
class Task {
  // properties
  int? id;
  String? title;
  String? notes;
  String? isDone;

  // Default constructor
  Task({this.id, this.title, this.notes, this.isDone});

  // Getters
  int? get _id => id;
  String? get _title => title;
  String? get _isDone => isDone;
  String? get _notes => notes;

  // Setters
  set _title(String? newTitle) {
    this.title = newTitle;
  }

  set _notes(String? newNotes) {
    this.notes = newNotes;
  }

  set _isDone(String? NewisDone) {
    this.isDone = NewisDone;
  }

  // Convert a Task object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['isDone'] = _isDone;
    map['notes'] = _notes;
    return map;
  }

  // Extract a Task object from a Map object
  Task.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.isDone = map['isDone'];
    this.notes = map['notes'];
  }
}
