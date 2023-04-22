import 'package:flutter/material.dart';
import '../DataBase/Database_helper.dart';
import '../models/Child.dart';

class NewChild extends StatefulWidget {
  final Function addTx;

  NewChild(this.addTx);

  @override
  _NewChildState createState() => _NewChildState();
}

class _NewChildState extends State<NewChild> {
  C_DataBaseHelper helper = C_DataBaseHelper();
  final titleController = TextEditingController();
  Child? child;

  void updateTitle() {
    if (titleController.text.isEmpty) {
      return;
    }
    child?.title = titleController.text;
    // final enteredTitle = _titleController.text;
    // widget.addTx(enteredTitle, task);
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _save() async {
    final enteredTitle = titleController.text;
    if (enteredTitle.isEmpty) {
      return;
    }
    widget.addTx(enteredTitle, child);
    int result;
    if (child?.id != null) {
      // Case 1: Update operation
      result = await helper.updateChild(child!);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertChild(child!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
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
                  IconButton(
                      icon: Icon(
                        Icons.ac_unit_sharp,
                        size: 25.0,
                      ),
                      onPressed: () {}),
                  Expanded(
                    child: TextField(
                      controller: titleController,
                      onSubmitted: (_) {
                        updateTitle();
                      },
                      decoration: InputDecoration(
                          hintText: "Add tasks...", border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 25.0,
                    ),
                    // Icon(Icons.send),
                    onPressed: () {
                      setState(() {
                        debugPrint("Save button clicked");
                        _save();
                        Navigator.of(context).pop();
                      });
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
