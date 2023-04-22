// importing core dart packages
import 'package:flutter_filex/helpers/ColorConst.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../DataBase/Database_helper.dart';
import '../Models/Task.dart';

//defining NewTransaction as a stateful widget
class NewTask extends StatefulWidget {
  //passing addTx as a parameter into NewTransaction
  NewTask(this.addTx);

  //instantiating addTx having type Function
  final Function addTx;

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  //defining _titleController as a TextEditingController()
  DataBaseHelper helper = DataBaseHelper();
  final _titleController = TextEditingController();
  Task? task;

  void updateTitle() {
    task?.title = _titleController.text;
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _save() async {
    final enteredTitle = _titleController.text;
    if (enteredTitle == null || enteredTitle.length == 0) return;

    // call new task
    widget.addTx.call(enteredTitle, task);
    if (task != null) {
      int result;
      if (kDebugMode) {
        print('_alexTR_logging_: NewTask : _save : task: ${task!.title}');
      }
      if (task!.id != null) {
        // Case 1: Update operation
        result = await helper.updateTask(task!, task!.id.toString());
      } else {
        // Case 2: Insert Operation
        result = await helper.insertTask(task!);
      }
    }

    Navigator.of(context).pop();
  }

  // the build method
  @override
  Widget build(BuildContext context) {
    //returning a card
    return Card(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _titleController,
                        onSubmitted: (_) => updateTitle(),
                        decoration: InputDecoration(
                            hintText: "Thêm công việc...",
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send,
                        color: ColorConst.toDoTaskAppBarColor, size: 25.0),
                    onPressed: () {
                      _save();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
