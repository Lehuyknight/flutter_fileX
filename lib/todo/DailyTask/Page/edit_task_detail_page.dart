import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter_filex/todo/DailyTask/Const/color_const.dart';
import 'package:flutter_filex/todo/DailyTask/Database/daily_task_database_helper.dart';
import 'package:flutter_filex/todo/DailyTask/models/daily_task_model/daily_task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../helpers/ColorConst.dart';
import '../../../utils/dimension_const.dart';

class EditTaskDetailPage extends StatefulWidget {
  EditTaskDetailPage({Key? key, required this.task, required this.dailyTask})
      : super(key: key);
  final DailyTaskModel task;
  final List<DailyTaskModel> dailyTask;

  @override
  State<EditTaskDetailPage> createState() => _EditTaskDetailPageState();
}

class _EditTaskDetailPageState extends State<EditTaskDetailPage> {
  late Time _time;
  void _insertDailyTask(
      Color color, String note, String time, List<String> day) {
    final newTask = DailyTaskModel(
      color: color.value.toString(),
      note: note,
      time: time,
      day: day.join(','),
    );
    DailyTaskDataBaseHelper().rawInsertTaskList(newTask);
  }

  void _updateDailyTask(
      Color color, String note, String time, List<String> day) {
    final newTask = DailyTaskModel(
      color: color.value.toString(),
      note: note,
      time: time,
      day: day.join(','),
    );
    DailyTaskDataBaseHelper().updateSchedule(newTask, oldValue);
  }

  late String selectedValue;
  final colorItem = colorConstList;
  late List<String> listDay;
  late final List<String> item;
  final TextEditingController _textEditingController = TextEditingController();
  Time time = Time.fromTimeOfDay(TimeOfDay.fromDateTime(DateTime.now()), 0);
  late String hour;
  late String minutes;
  late String oldValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.dailyTask.forEach((element) {
      if (colorItem.contains(element.color)) {
        colorItem.remove(element.color);
      }
    });
    item = colorItem;
    selectedValue = widget.task.color!;
    oldValue = widget.task.color!;
    _textEditingController.text = widget.task.note!;
    _time = Time.fromTimeOfDay(
        TimeOfDay(
            hour: int.parse(widget.task.time!.split(':')[0]),
            minute: int.parse(widget.task.time!.split(':')[1])),
        0);
    hour = widget.task.time!.split(':')[0];
    minutes = widget.task.time!.split(':')[1];
    listDay = widget.task.day!.split(',');
  }

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: GestureDetector(
          child: Text(
            'Chỉnh sửa chi tiết',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onTap: () {},
        ),
        actions: [
          if (_textEditingController.text.isNotEmpty && listDay.length > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                child: Icon(Icons.save, color: Colors.white),
                onTap: () {
                  _updateDailyTask(Color(int.parse(selectedValue)),
                      _textEditingController.text, '$hour:$minutes', listDay);
                  Navigator.of(context).pop('result');
                },
              ),
            )
        ],
        centerTitle: true,
        backgroundColor: ColorConst.toDoTaskAppBarColor,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: ColorConst.toDoTaskAppBarColor))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 22.0),
                  child: Row(
                    children: [
                      Text(
                        'Màu sắc',
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      // GestureDetector(
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle, color: Colors.black),
                      //     height: 20,
                      //     width: 20,
                      //   ),
                      //   onTap: () {
                      //     setState(() {
                      //       showStack = true;
                      //     });
                      //     print(showStack);
                      //   },
                      // )
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          customButton: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(int.parse(selectedValue))),
                            height: 20,
                            width: 20,
                          ),
                          items: item
                              .map((e) => DropdownMenuItem<String>(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(int.parse(e))),
                                      height: 20,
                                      width: 20,
                                    ),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value.toString();
                            });
                          },
                          dropdownStyleData: DropdownStyleData(
                            width: 40,
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                            ),
                            elevation: 8,
                            offset: const Offset(0, 8),
                          ),
                          menuItemStyleData: MenuItemStyleData(
                            padding: const EdgeInsets.all(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: ColorConst.toDoTaskAppBarColor))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: TextField(
                    autocorrect: false,
                    controller: _textEditingController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        labelText: 'Ghi chú',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 16),
                        alignLabelWithHint: true,
                        focusedBorder: InputBorder.none,
                        focusColor: ColorConst.toDoTaskAppBarColor,
                        border: InputBorder.none),
                    maxLines: 7,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 1, color: ColorConst.toDoTaskAppBarColor),
                  ),
                ),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text(
                            'Giờ nhắc:',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(18.0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                                border: Border.all(
                                    color: ColorConst.toDoTaskAppBarColor)),
                            alignment: Alignment.center,
                            child: Text(
                              '$hour',
                              // '18',
                              style: TextStyle(
                                  fontSize: 28,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              showPicker(
                                accentColor: ColorConst.toDoTaskAppBarColor,
                                blurredBackground: true,
                                is24HrFormat: true,
                                context: context,
                                value: _time,
                                onChange: (value) {
                                  time = value;
                                  setState(() {
                                    hour = value.hour.toString();
                                    minutes = value.minute.toString();
                                  });
                                },
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text(
                            ':',
                            style: TextStyle(
                                fontSize: 28,
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(18.0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                                border: Border.all(
                                    color: ColorConst.toDoTaskAppBarColor)),
                            alignment: Alignment.center,
                            child: Text(
                              '$minutes',
                              // '30',
                              style: TextStyle(
                                  fontSize: 28,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              showPicker(
                                accentColor: ColorConst.toDoTaskAppBarColor,
                                blurredBackground: true,
                                is24HrFormat: true,
                                context: context,
                                value: _time,
                                onChange: (value) {
                                  setState(() {
                                    hour = value.hour.toString();
                                    minutes = value.minute.toString();
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: ColorConst.toDoTaskAppBarColor))),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 10.0, vertical: 8.0),
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         'Text',
                      //         style: TextStyle(fontSize: 16),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Row(
                      //   children: [
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      //         border:
                      //             Border.all(color: ColorConst.toDoTaskAppBarColor),
                      //       ),
                      //       width: 40,
                      //       height: 40,
                      //     )
                      //   ],
                      // )
                      Container(
                        child: MultiSelectChipField<String>(
                          items: [
                            MultiSelectItem('2', 'T2'),
                            MultiSelectItem('3', 'T3'),
                            MultiSelectItem('4', 'T4'),
                            MultiSelectItem('5', 'T5'),
                            MultiSelectItem('6', 'T6'),
                            MultiSelectItem('7', 'T7'),
                            MultiSelectItem('8', 'CN'),
                          ],
                          initialValue: listDay,
                          chipShape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: ColorConst.toDoTaskAppBarColor),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          title: Text('Lặp lại:'),
                          selectedTextStyle:
                              TextStyle(color: ColorConst.toDoTaskAppBarColor),
                          onTap: (p0) {
                            setState(() {
                              listDay = p0;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
