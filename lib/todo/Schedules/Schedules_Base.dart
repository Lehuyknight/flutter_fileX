import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_filex/todo/Schedules/edit_schedules_page.dart';
import 'package:flutter_filex/todo/Schedules/new_schedules_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../helpers/ColorConst.dart';
import './DataBase/S_Database_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'models/Schedule.dart';
import 'widgets/schedule_list.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SW2 extends StatefulWidget {
  @override
  _SW2State createState() => _SW2State();
}

class _SW2State extends State<SW2> {
  List<Schedule> _userSchedules = [];

  void _addNewSchedule(String txTitle, DateTime chosenDate, Schedule newSC,
      DateTime chosenTime) async {
    final newSC = Schedule(
        title: txTitle,
        date: chosenDate.toString(),
        isDone: 'false',
        time: chosenTime.toString());
    int result = await S_DataBaseHelper().insertSchedule(newSC);
    if (result != 0) {
      // _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _deleteSchedule(String id) async {
    _userSchedules.removeWhere((element) => element.id == id);
    int result = await S_DataBaseHelper().deleteSchedule(id.toString());
    if (result != 0) {
      updateListView();
      _showSnackBar(context, 'Xóa thành công');
    }
  }

  void _markAsDone(String id, String isDone) async {
    // bool done = !Done;
    // final newTx =
    //     Schedule(title: newtitle, isDone: isDone, date: newDate, time: newTime);
    // int result1 = await S_DataBaseHelper().deleteSchedule(id);
    // if (result1 != 0) {
    //   updateListView();
    // }
    // int result = await S_DataBaseHelper().insertSchedule(newTx);
    // if (result != 0) {
    //   updateListView();
    // }
    int result = await S_DataBaseHelper().changeStatus(id, isDone);
    if (result != 0) updateListView();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    if (_userSchedules == null) {
      _userSchedules = <Schedule>[];
      updateListView();
    }
    // updateListView();
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: GestureDetector(
            child: Text(
              'Quản lý công việc',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onTap: () {
              updateListView();
            },
          ),
          centerTitle: true,
          backgroundColor: ColorConst.toDoTaskAppBarColor,
        ),
        body: Container(
            height: double.infinity,
            decoration:
                BoxDecoration(color: isDarkMode ? Colors.black : Colors.white),
            child: _userSchedules.length == 0
                ? Center(
                    child: ScheduleList(_userSchedules, _deleteSchedule,
                        _markAsDone, updateListView),
                  )
                // : SingleChildScrollView(
                //     child: Center(
                //       child: Padding(
                //         padding: const EdgeInsets.only(bottom: 58.0),
                //         // child: TasksList(_userTasks, _deleteTask, _markAsDone),
                //         child: Text('asdasda'),
                //       ),
                //     ),
                //   ),
                : ScheduleList(_userSchedules, _deleteSchedule, _markAsDone,
                    updateListView)),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConst.toDoTaskAppBarColor,
          child: Icon(Icons.add),
          onPressed: () async {
            var result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewSchedulesScreen()));
            if (result != null && result.isNotEmpty) {
              updateListView();
            }
          },
        ),
      ),
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = S_DataBaseHelper().initializeDatabase();
    dbFuture.then((database) {
      Future<List<Schedule>> noteListFuture = S_DataBaseHelper().getSCList();
      noteListFuture.then((_userSchedules) {
        if (!mounted) return;
        setState(() {
          this._userSchedules = _userSchedules;
        });
      });
    });
  }

  void _showSnackBar(BuildContext context, String s) {
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      content: AwesomeSnackbarContent(
        title: 'Done',
        message: s,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.success,
      ),
    );
  }
}
