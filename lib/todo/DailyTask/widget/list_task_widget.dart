import 'package:flutter_filex/helpers/ColorConst.dart';
import 'package:flutter_filex/todo/DailyTask/Page/edit_task_list_page.dart';
import 'package:flutter_filex/todo/DailyTask/models/daily_task_model/daily_task_model.dart';
import 'package:flutter/material.dart';

import 'list_tast_item.dart';

class ListTaskWidget extends StatelessWidget {
  ListTaskWidget(
      {Key? key,
      required this.taskList,
      required this.deleteFunction,
      required this.updateFunction})
      : super(key: key);
  final List<DailyTaskModel> taskList;
  final Function(String) deleteFunction;
  final Function() updateFunction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
          border: Border.all(color: ColorConst.toDoTaskAppBarColor),
        ),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: Text('Chú thích:', style: TextStyle(fontSize: 16)),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: GestureDetector(
                    child: Icon(
                      Icons.edit_outlined,
                      color: ColorConst.toDoTaskAppBarColor,
                    ),
                    onTap: () async {
                      var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditTaskList(
                                    listTask: taskList,
                                    deleteTask: deleteFunction,
                                  )));
                      if (result != null) {
                        updateFunction();
                      }
                    },
                  ),
                )
              ],
            ),
            Column(
              // children: [
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 8.0),
              //   child: ListTaskItem(
              //       color: Colors.blueAccent,
              //       note: 'Different data',
              //       time: '9:10'),
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 8.0),
              //   child: ListTaskItem(
              //       color: Colors.black, note: 'Data', time: '8:30'),
              // )
              // ],
              children: taskList.map((e) {
                return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListTaskItem(
                      color: Color(int.parse(e.color!)),
                      note: e.note ?? '',
                      time: e.time!,
                    ));
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
