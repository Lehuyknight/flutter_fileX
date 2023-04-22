import 'package:flutter_filex/todo/DailyTask/models/daily_task_model/daily_task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DailyTaskDataBaseHelper {
  // singletons
  static DailyTaskDataBaseHelper? _dataBaseHelper; //singleton DataBaseHelper
  static Database? _database; //singleton Database

  String dailyTaskTable = 'Dailytasktable';
  String colorTable = 'Colortable';
  String weekdayTable = 'Weekdaytable';
  String colId = 'id';
  String colColor = 'color';
  String colNote = 'note';
  String colTime = 'time';
  String colDate = 'day';

  DailyTaskDataBaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DailyTaskDataBaseHelper() {
    if (_dataBaseHelper == null) {
      _dataBaseHelper = DailyTaskDataBaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _dataBaseHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  //initializeDatabase() defination
  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'week.db';

    // Open/create the database at a given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  // _createDb() defination
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $dailyTaskTable($colColor STRING PRIMARY KEY, $colNote TEXT, $colTime TEXT, $colDate TEXT)');
    await db.execute(
        'CREATE TABLE $colorTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colColor TEXT, CONSTRAINT fk_color FOREIGN KEY($colColor) REFERENCES $dailyTaskTable($colColor))');
    await db.execute(
        'CREATE TABLE $weekdayTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colDate TEXT, $colColor TEXT, CONSTRAINT fk_color FOREIGN KEY($colColor) REFERENCES $dailyTaskTable($colColor))');
  }

  // Fetch Operation: Get all Task objects from database

  Future<List<Map<String, dynamic>>> getDailyMapListByDate() async {
    Database db = await this.database;
    var result = await db.query(dailyTaskTable);
    return result;
  }

  Future<List<Map<String, dynamic>>> getSCMapList() async {
    Database db = await this.database;
    // var result = await db.rawQuery('SELECT $dailyTaskTable.$colColor, $dailyTaskTable.$colNote, $dailyTaskTable.$colTime, $weekdayTable.$colDate FROM $dailyTaskTable INNER JOIN $weekdayTable WHERE $weekdayTable.$colColor = $dailyTaskTable.$colColor ');
    var result = await db.query(dailyTaskTable);
    return result;
  }

  Future<int> rawInsertTaskList(DailyTaskModel dailyTask) async {
    Database db = await this.database;
    var result = await db.rawInsert(
        'INSERT INTO $dailyTaskTable($colColor, $colTime, $colNote, $colDate) VALUES (?, ?, ?, ?)',
        [dailyTask.color, dailyTask.time, dailyTask.note, dailyTask.day]);
    print(result);
    // dailyTask.day!.forEach((element) async {
    //   await db.rawInsert(
    //       'INSERT INTO $weekdayTable($colColor, $colDate) VALUES (?, ?)',
    //       [dailyTask.color, element]);
    // });
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertSchedule(DailyTaskModel dailyTask) async {
    Database db = await this.database;
    var result = await db.insert(dailyTaskTable, dailyTask.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateSchedule(DailyTaskModel dailyTask, String? oldColor) async {
    var db = await this.database;
    var result = await db.rawUpdate(
        'UPDATE $dailyTaskTable SET $colColor = ?, $colNote = ?, $colDate = ?, $colTime = ? WHERE $colColor = ?',
        [
          dailyTask.color,
          dailyTask.note,
          dailyTask.day,
          dailyTask.time,
          oldColor ?? dailyTask.color
        ]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteTask(String color) async {
    var db = await this.database;
    int result = await db
        .rawDelete('DELETE FROM $dailyTaskTable WHERE $colColor = $color');
    return result;
  }

  Future<int> changeColor(String id, String newColor, String oldColor) async {
    var db = await this.database;
    int result = await db.update(dailyTaskTable, {'$colColor': newColor},
        where: '$colId = $oldColor');
    return result;
  }

  // Get number of Task objects in database
  Future<int?> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $dailyTaskTable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Task List' [ List<Task> ]
  Future<List<DailyTaskModel>> getDailyTaskList() async {
    var SCMapList = await getSCMapList(); // Get 'Map List' from database
    int count = SCMapList.length; // Count the number of map entries in db table

    List<DailyTaskModel> dailyTaskList = <DailyTaskModel>[];
    // For loop to create a 'Note List' from a 'Map List'

    for (int i = 0; i < count; i++) {
      dailyTaskList.add(DailyTaskModel.fromJson(SCMapList[i]));
    }
    return dailyTaskList;
  }
}
