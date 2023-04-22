//importing core packages
import 'package:flutter_filex/helpers/ColorConst.dart';
import 'package:flutter_filex/todo/core/new_note_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sqflite/sqflite.dart';

//importing other elements into the base file
import './Models/Task.dart';
import './Widgets/new_task.dart';
import './Widgets/task_list.dart';
import './DataBase/Database_helper.dart';

//defining MyHomePage as a stateful widget
class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  //defining a list names _userTransactions which is of type Transaction
  List<Task> _userTasks = [];

  void _addNewTask(String txTitle, Task newTx) async {
    final newTx = Task(title: txTitle, isDone: 'false');
    int result = await DataBaseHelper().insertTask(newTx);
    if (result != 0) {
      updateListView();
    }
  }

//defining the ModalSheet
  _buildCreateNewNote(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          //passing _addNewTransaction into NewTransaction()
          child: NewTask(_addNewTask),
          //to close the bottom sheet upon pressing elsewhere
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTask(String id) async {
    _userTasks.removeWhere((tx) => tx.id == id);
    int result = await DataBaseHelper().deleteTask(id.toString());
    if (result != 0) {
      //_showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _markAsDone(String newtitle, int id) async {
    // bool done = !Done;
    final updateTask = Task(id: id, title: newtitle, isDone: 'true');
    if (kDebugMode) {
      print('_alexTR_logging_ : _markAsDone : id : $id');
    }
    int result0 = await DataBaseHelper().updateTask(updateTask, id.toString());
    if (result0 != 0) {
      if (kDebugMode) {
        print('_alexTR_logging_ : _markAsDone : result0 : $result0');
      }
      updateListView();
      return;
    }

    int result1 = await DataBaseHelper().deleteTask(id.toString());
    if (result1 != 0) {
      // _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
    int result = await DataBaseHelper().insertTask(updateTask);
    if (result != 0) {
      // _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _markAsUndone(String newtitle, int id) async {
    // bool done = !Done;
    final updateTask = Task(id: id, title: newtitle, isDone: 'false');
    int result0 = await DataBaseHelper().updateTask(updateTask, id.toString());
    if (result0 != 0) {
      updateListView();
      return;
    }

    int result1 = await DataBaseHelper().deleteTask(id.toString());
    if (result1 != 0) {
      // _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
    int result = await DataBaseHelper().insertTask(updateTask);
    if (result != 0) {
      // _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  @override
  void initState() {
    super.initState();
    updateListView();
    if (_userTasks.length == 0) {
      _userTasks = <Task>[];
    }
    // _fetchTasks();
    updateListView();
  }

  //the build method
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: GestureDetector(
          child: Text(
            'Danh sách ghi chú',
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
          child: _userTasks.length == 0
              ? Center(
                  child: TasksList(
                      _userTasks, _deleteTask, _markAsDone, _markAsUndone),
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
              : TasksList(_userTasks, _deleteTask, _markAsDone, _markAsUndone)),

      //the extended FAB used to show the modal sheet
      floatingActionButton: FloatingActionButton(
        // label: Text(
        //   'Thêm ghi chú',
        //   style: TextStyle(
        //       color: Colors.white, fontSize: 19, fontWeight: FontWeight.w600),
        // ),
        child: Icon(Icons.add),
        backgroundColor: ColorConst.toDoTaskAppBarColor,
        // onPressed: () => _buildCreateNewNote(context),
        onPressed: () async {
          final String result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewNoteScreen()));
          if (result != null && result.isNotEmpty) {
            updateListView();
          }
        },
      ),
    );
  }

  void _fetchTasks() {
    final Future<Database> dbFuture = DataBaseHelper().initializeDatabase();
    dbFuture.then((database) {
      Future<List<Task>> noteListFuture = DataBaseHelper().getNoteList();
      noteListFuture.then((_userTasks) {
        if (!mounted) return;
        setState(() {
          this._userTasks = _userTasks;
        });
        print(this._userTasks);
      });
    });
  }

  void updateListView() {
    final Future<Database> dbFuture = DataBaseHelper().initializeDatabase();
    dbFuture.then((database) {
      Future<List<Task>> noteListFuture = DataBaseHelper().getNoteList();
      noteListFuture.then((_userTasks) {
        if (!mounted) return;
        setState(() {
          this._userTasks = _userTasks;
        });
      });
    });
  }

  void refresh() {
    setState(() {});
  }
}
