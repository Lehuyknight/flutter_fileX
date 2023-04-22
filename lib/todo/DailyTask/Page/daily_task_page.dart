import 'package:flutter_filex/todo/DailyTask/Page/new_task_page.dart';
import 'package:flutter_filex/todo/DailyTask/models/daily_task_model/daily_task_model.dart';
import 'package:flutter_filex/todo/DailyTask/widget/day_widget.dart';
import 'package:flutter_filex/todo/DailyTask/widget/list_task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import '../../../helpers/ColorConst.dart';
import '../Database/daily_task_database_helper.dart';

class DailyTaskPage extends StatefulWidget {
  DailyTaskPage({Key? key}) : super(key: key);

  @override
  State<DailyTaskPage> createState() => _DailyTaskPageState();
}

class _DailyTaskPageState extends State<DailyTaskPage> {
  List<DailyTaskModel> dailyTask = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateListView();
  }

  Future<void> _deleteTask(String color) async {
    await DailyTaskDataBaseHelper().deleteTask(color);
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    if (dailyTask == null) {
      dailyTask = <DailyTaskModel>[];
      updateListView();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: GestureDetector(
          child: Text(
            'Kế hoạch tuần',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onTap: () {},
        ),
        centerTitle: true,
        backgroundColor: ColorConst.toDoTaskAppBarColor,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTaskWidget(
                taskList: dailyTask,
                deleteFunction: _deleteTask,
                updateFunction: updateListView,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  DayWidget(text: 'Thứ 2', value: '2', listTask: dailyTask),
                  DayWidget(text: 'Thứ 3', value: '3', listTask: dailyTask),
                  DayWidget(text: 'Thứ 4', value: '4', listTask: dailyTask),
                  DayWidget(text: 'Thứ 5', value: '5', listTask: dailyTask),
                  DayWidget(text: 'Thứ 6', value: '6', listTask: dailyTask),
                  DayWidget(text: 'Thứ 7', value: '7', listTask: dailyTask),
                  DayWidget(text: 'Chủ nhật', value: '8', listTask: dailyTask),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewTaskPage(
                        listTask: dailyTask,
                      )));
          if (result != null) {
            updateListView();
          }
        },
        child: Icon(Icons.add),
        backgroundColor: ColorConst.toDoTaskAppBarColor,
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
