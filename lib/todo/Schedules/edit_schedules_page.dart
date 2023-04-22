import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import '../../helpers/ColorConst.dart';
import '../../utils/dimension_const.dart';
import '../../utils/textstyle_ext.dart';
import 'DataBase/S_Database_helper.dart';
import 'models/Schedule.dart';

class EditSchedulesScreen extends StatefulWidget {
  const EditSchedulesScreen({Key? key, required this.schedule})
      : super(key: key);
  final Schedule schedule;

  @override
  State<EditSchedulesScreen> createState() => _EditSchedulesScreenState();
}

class _EditSchedulesScreenState extends State<EditSchedulesScreen> {
  bool isDone = true;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime date = DateTime.now();
  Time time = Time.fromTimeOfDay(TimeOfDay.fromDateTime(DateTime.now()), 0);
  String hour = DateTime.now().hour.toString();
  String minutes = DateTime.now().minute.toString();

  void _updateSchedule() {
    final newSC = Schedule(
        id: widget.schedule.id,
        title: _titleController.text,
        date: date.toString(),
        note: _noteController.text,
        isDone: widget.schedule.isDone,
        time: '${time.hour}:${time.minute}');

    S_DataBaseHelper().updateSchedule(newSC);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text = widget.schedule.title!;
    _noteController.text = widget.schedule.note ?? '';
    _dateController.text =
        '${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.schedule.date!))}';
    date = DateTime.parse(widget.schedule.date!);
    time = Time.fromTimeOfDay(
        TimeOfDay(
            hour: int.parse(widget.schedule.time!.split(':')[0]),
            minute: int.parse(widget.schedule.time!.split(':')[1])),
        0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _noteController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    Time _time = Time.fromTimeOfDay(TimeOfDay.fromDateTime(DateTime.now()), 0);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Chỉnh sửa',
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
                  _updateSchedule();
                  Navigator.of(context).pop('result');
                },
              ),
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: kMediumPadding,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 1, color: ColorConst.toDoTaskAppBarColor),
                  ),
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyles.defaultStyle.bold.copyWith(
                        color: isDarkMode
                            ? ColorConst.toDoTaskAppBarColor
                            : Colors.black),
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
                      hintStyle: TextStyles.defaultStyle.bold,
                      border: InputBorder.none,
                    ),
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
                  border: Border(
                    bottom: BorderSide(
                        width: 1, color: ColorConst.toDoTaskAppBarColor),
                  ),
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyles.defaultStyle.bold.copyWith(
                        color: isDarkMode
                            ? ColorConst.toDoTaskAppBarColor
                            : Colors.black),
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
                      border: InputBorder.none,
                    ),
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
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 1, color: ColorConst.toDoTaskAppBarColor),
                  ),
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: GestureDetector(
                    child: Row(children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyles.defaultStyle.bold.copyWith(
                              color: isDarkMode
                                  ? ColorConst.toDoTaskAppBarColor
                                  : Colors.black),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Note',
                            focusColor: ColorConst.toDoTaskAppBarColor,
                            labelStyle:
                                MaterialStateTextStyle.resolveWith((states) {
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
                            enabled: false,
                            labelText:
                                'Date: ${_dateController.text.isNotEmpty ? _dateController.text : DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                            hintStyle: TextStyles.defaultStyle.bold,
                            border: InputBorder.none,
                          ),
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
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(18),
                        child: Icon(
                          Icons.calendar_month_rounded,
                          color: ColorConst.toDoTaskAppBarColor,
                        ),
                      )
                    ]),
                    onTap: () async {
                      print('tapped');
                      List<DateTime> _dates = [];
                      var results = await showCalendarDatePicker2Dialog(
                        context: context,
                        config: CalendarDatePicker2WithActionButtonsConfig(
                          currentDate: date,
                          firstDate: DateTime.now(),
                        ),
                        dialogSize: const Size(325, 400),
                        value: _dates,
                        borderRadius: BorderRadius.circular(15),
                      );
                      setState(() {
                        results != null && results.length != 0
                            ? {
                                _dateController.text = DateFormat('dd/MM/yyyy')
                                    .format(results[0] != null
                                        ? results[0]!
                                        : date),
                                date = results[0]!
                              }
                            : DateFormat('dd/MM/yyyy').format(DateTime.now());
                      });
                    },
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
                            'Time',
                            style: TextStyles.defaultStyle.bold.copyWith(
                                color: ColorConst.toDoTaskAppBarColor),
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
                              '${time.hour}',
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
                              '${time.minute}',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
