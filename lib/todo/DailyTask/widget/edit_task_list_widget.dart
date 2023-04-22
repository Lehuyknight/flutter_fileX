import 'package:flutter_filex/helpers/ColorConst.dart';
import 'package:flutter_filex/todo/DailyTask/Page/edit_task_detail_page.dart';
import 'package:flutter_filex/todo/DailyTask/models/daily_task_model/daily_task_model.dart';
import 'package:flutter/material.dart';

class EditTaskListWidget extends StatelessWidget {
  const EditTaskListWidget(
      {Key? key,
      required this.task,
      required this.deleteFunction,
      required this.dailyTask,
      required this.updateFunction})
      : super(key: key);
  final DailyTaskModel task;
  final List<DailyTaskModel> dailyTask;
  final Function(String) deleteFunction;
  final Function() updateFunction;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorConst.toDoTaskAppBarColor),
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Color(int.parse(task.color!)),
                    ),
                    width: 20,
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      task.note!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      task.time!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Transform.scale(
                      scale: 1.5,
                      child: GestureDetector(
                        onTap: () async {
                          var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditTaskDetailPage(
                                        task: task,
                                        dailyTask: dailyTask,
                                      )));
                          if (result != null) {
                            updateFunction();
                          }
                        },
                        child: Icon(
                          Icons.edit_outlined,
                          color: ColorConst.toDoTaskAppBarColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Transform.scale(
                        scale: 1.5,
                        child: GestureDetector(
                            onTap: () {
                              deleteFunction(task.color!);
                            },
                            child: Icon(Icons.close, color: Colors.black))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
