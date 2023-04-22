import 'package:flutter_filex/helpers/ColorConst.dart';
import 'package:flutter_filex/todo/DailyTask/models/daily_task_model/daily_task_model.dart';
import 'package:flutter_filex/utils/dimension_const.dart';
import 'package:flutter/material.dart';

class DayWidget extends StatelessWidget {
  const DayWidget(
      {Key? key,
      required this.text,
      required this.value,
      required this.listTask})
      : super(key: key);
  final String text;
  final String value;
  final List<DailyTaskModel> listTask;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorConst.toDoTaskAppBarColor),
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
        ),
        width: MediaQuery.of(context).size.width / 2.2,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text),
              SizedBox(
                height: kDefaultPadding,
              ),
              Wrap(
                  children: listTask
                      .where((element) => element.day!.contains(value))
                      .toList()
                      .map((e) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(int.parse(e.color!))),
                    height: 20,
                    width: 20,
                  ),
                );
              }).toList())
            ],
          ),
        ),
      ),
    );
  }
}
