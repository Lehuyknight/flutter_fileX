import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import './Models/Task.dart';
import './DataBase/Database_helper.dart';
import '../../helpers/ColorConst.dart';
import '../../utils/dimension_const.dart';
import '../../utils/textstyle_ext.dart';

class NewNoteScreen extends StatefulWidget {
  const NewNoteScreen({Key? key}) : super(key: key);

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  bool isDone = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  void _addNewTask(String txTitle, String txNote) async {
    final newTx = Task(title: txTitle, notes: txNote, isDone: 'false');
    int result = await DataBaseHelper().insertTask(newTx);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Tạo ghi chú mới',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: ColorConst.toDoTaskAppBarColor,
        actions: [
          if (isDone == true)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Icon(Icons.check),
                onTap: () {
                  _addNewTask(_titleController.text, _noteController.text);
                  Navigator.of(context).pop('result');
                },
              ),
            )
        ],
      ),
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: kMediumPadding,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(kDefaultPadding),
                ),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyles.defaultStyle.bold
                      .copyWith(color: ColorConst.toDoTaskAppBarColor),
                  decoration: InputDecoration(
                      hintText: 'Title',
                      focusColor: ColorConst.toDoTaskAppBarColor,
                      labelStyle: MaterialStateTextStyle.resolveWith((states) {
                        if (states.contains(MaterialState.focused)) {
                          return const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: ColorConst.toDoTaskAppBarColor);
                        } else {
                          return TextStyle(
                              color: ColorConst.toDoTaskAppBarColor,
                              fontWeight: FontWeight.bold);
                        }
                      }),
                      labelText: 'Title',
                      hintStyle: TextStyles.defaultStyle.bold),
                  controller: _titleController,
                  onChanged: (value) {
                    if (_titleController.text.isNotEmpty ||
                        _noteController.text.isNotEmpty) {
                      setState(() {
                        isDone = true;
                      });
                    } else {
                      setState(() {
                        isDone = false;
                      });
                    }
                  },
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(kDefaultPadding),
                ),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyles.defaultStyle.bold
                      .copyWith(color: ColorConst.toDoTaskAppBarColor),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Note',
                      focusColor: ColorConst.toDoTaskAppBarColor,
                      labelStyle: MaterialStateTextStyle.resolveWith((states) {
                        if (states.contains(MaterialState.focused)) {
                          return const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: ColorConst.toDoTaskAppBarColor);
                        } else {
                          return TextStyle(
                              color: ColorConst.toDoTaskAppBarColor,
                              fontWeight: FontWeight.bold);
                        }
                      }),
                      labelText: 'Note',
                      hintStyle: TextStyles.defaultStyle.bold,
                      border: InputBorder.none),
                  controller: _noteController,
                  onChanged: (value) {
                    if (_titleController.text.isNotEmpty) {
                      setState(() {
                        isDone = true;
                      });
                    } else {
                      setState(() {
                        isDone = false;
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
