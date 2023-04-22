import 'package:flutter_filex/todo/DailyTask/models/daily_task_model/daily_task_model.dart';
import 'package:flutter_filex/todo/DailyTask/widget/edit_task_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import '../../../helpers/ColorConst.dart';
import '../Database/daily_task_database_helper.dart';

class EditTaskList extends StatefulWidget {
  const EditTaskList(
      {Key? key, required this.listTask, required this.deleteTask})
      : super(key: key);
  final List<DailyTaskModel> listTask;
  final Function(String) deleteTask;

  @override
  State<EditTaskList> createState() => _EditTaskListState();
}

class _EditTaskListState extends State<EditTaskList> {
  List<DailyTaskModel> dailyTask = [];
  Future<void> _deleteTask(String color) async {
    await widget.deleteTask(color);
    updateListView();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dailyTask = widget.listTask;
  }

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop('result');
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: GestureDetector(
          child: Text(
            'Chỉnh sửa kế hoạch',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onTap: () {},
        ),
        centerTitle: true,
        backgroundColor: ColorConst.toDoTaskAppBarColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: dailyTask
              .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EditTaskListWidget(
                      task: e,
                      deleteFunction: _deleteTask,
                      updateFunction: updateListView,
                      dailyTask: dailyTask,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  void updateListView() {
    final Future<Database> dbFuture =
        DailyTaskDataBaseHelper().initializeDatabase();
    dbFuture.then((database) {
      Future<List<DailyTaskModel>> noteListFuture =
          DailyTaskDataBaseHelper().getDailyTaskList();
      noteListFuture.then((_userSchedules) {
        if (!mounted) return;
        setState(() {
          this.dailyTask = _userSchedules;
        });
      });
    });
  }
}
