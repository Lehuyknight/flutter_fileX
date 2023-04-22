//importing packages
import 'package:flutter_filex/helpers/ColorConst.dart';
import 'package:flutter_filex/todo/Schedules/Schedules_Base.dart';
import 'package:flutter_filex/todo/core/notes_screen.dart';
import 'package:flutter/material.dart';
import '../Home_Page/Gradient.dart';

// Defining Opt1()
// It has reference to ToDo() i.e. the To-Do List

class ScheduleItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //InkWell adds the onTap() functionality to Opt1(),
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SW2();
        }));
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Container(
          //row that contains the icon and the column
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                //the icon
                child: Image.asset('assets/icons/ic_schedule.png'),
              ),
              Expanded(
                flex: 3,
                //the column containing button and card
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      //the raised button
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  'Quản lý công việc',
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        //the card
                        children: [
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'Tạo việc cần làm',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Spacer(
                    //   flex: 1,
                    // ),
                  ],
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border.all(color: ColorConst.toDoTaskAppBarColor, width: 0.5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }
}
