//importing packages
import 'package:flutter_filex/helpers/ColorConst.dart';
import 'package:flutter_filex/todo/DailyTask/Page/daily_task_page.dart';
import 'package:flutter/material.dart';

import '../Schedules/Schedules_Base.dart';
import '../core/notes_screen.dart';
import '../widget/home_item_widget.dart';

class ToDoHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //using materialApp
    return Scaffold(
        //implementing an appbar
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Quản lý công việc',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: ColorConst.toDoTaskAppBarColor,
        ),
        body: Container(
          child: Container(
            child: Container(
              //Using all the RaisedButtonIcons for Home
              child: Column(
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 3,
                    child: HomeItemWidget(
                      iconImage: Image.asset('assets/icons/ic_note.png'),
                      title: 'Ghi chú quan trọng',
                      destinationRoute: Notes(),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 3,
                    child: HomeItemWidget(
                      iconImage: Image.asset('assets/icons/ic_schedule.png'),
                      title: 'Quản lý công việc',
                      destinationRoute: SW2(),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                      flex: 3,
                      child: HomeItemWidget(
                        iconImage: Image.asset('assets/icons/ic_schedule.png'),
                        title: 'Kế hoạch hàng ngày',
                        destinationRoute: DailyTaskPage(),
                      )),
                  Spacer(
                    flex: 10,
                  ),
                  // Expanded(flex: 4, child: Opt4()),
                  // Spacer(
                  //   flex: 1,
                  // ),
                ],
              ),
            ),
          ),
        ) //implementing settings drawer
        // drawer: Settings(),
        // implementing Tabs
        // bottomNavigationBar: Tabs(),
        );
  }
}
