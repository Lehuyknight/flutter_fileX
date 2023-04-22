import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

import '../../../helpers/ColorConst.dart';
import '../edit_schedules_page.dart';
import '../models/Schedule.dart';

class ScheduleList extends StatelessWidget {
  final List<Schedule> schedules;
  final Function deleteTx;
  final Function markDone;
  final Function refresh;

  ScheduleList(this.schedules, this.deleteTx, this.markDone, this.refresh);

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    if (kDebugMode) {
      schedules.forEach((element) {
        print(
            '_alexTR_logging_: TasksList : build : task : id : ${element.id} : title : ${element.title} : isDone : ${element.isDone}');
      });
    }
    // return Container(
    //   height: 550,
    //   child: schedules.isEmpty
    //       ? SplashScreenSC()
    //       : ListView.builder(
    //           itemBuilder: (ctx, index) {
    //             return Padding(
    //               padding: EdgeInsets.all(9),
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   border: Border.all(color: Colors.black, width: 4),
    //                   borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(15.0),
    //                     topRight: Radius.circular(15.0),
    //                     bottomRight: Radius.circular(15.0),
    //                     bottomLeft: Radius.circular(15.0),
    //                   ),
    //                 ),
    //                 child: Card(
    //                   elevation: 5,
    //                   margin: EdgeInsets.symmetric(
    //                     vertical: 8,
    //                     horizontal: 5,
    //                   ),
    //                   child: Column(
    //                     children: [
    //                       ListTile(
    //                         leading: GradientIcon(
    //                           Icons.chevron_right,
    //                           40.0,
    //                           LinearGradient(
    //                             colors: <Color>[
    //                               Colors.yellow,
    //                               Colors.pink,
    //                               Colors.blue,
    //                             ],
    //                             begin: Alignment.topLeft,
    //                             end: Alignment.bottomRight,
    //                           ),
    //                         ),
    //                         title: Text(
    //                           schedules[index].title ?? 'Updating',
    //                           style: TextStyle(
    //                               decoration:
    //                                   (schedules[index].isDone == 'true')
    //                                       ? TextDecoration.lineThrough
    //                                       : null,
    //                               fontSize: 21,
    //                               fontFamily: 'Salsa-Regular',
    //                               fontWeight: FontWeight.w300),
    //                         ),
    //                         trailing: Wrap(
    //                           spacing: 12, // space between two icons
    //                           children: <Widget>[
    //                             InkWell(
    //                               onTap: () => showDialog<void>(
    //                                 context: context,
    //                                 barrierDismissible:
    //                                     false, // user must tap button!
    //                                 builder: (BuildContext context) {
    //                                   return AlertDialog(
    //                                     title: Text(
    //                                       'You just Tapped the "Done" button',
    //                                       style: TextStyle(
    //                                           fontSize: 28,
    //                                           fontFamily:
    //                                               'KaushanScript-Regular',
    //                                           fontWeight: FontWeight.w600),
    //                                     ),
    //                                     content: SingleChildScrollView(
    //                                       child: ListBody(
    //                                         children: <Widget>[
    //                                           Text(
    //                                             'Mark the Event as "Done"?',
    //                                             style: TextStyle(
    //                                                 color: Colors.black,
    //                                                 fontSize: 18,
    //                                                 fontFamily: 'Salsa-Regular',
    //                                                 fontWeight:
    //                                                     FontWeight.w300),
    //                                           ),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                     actions: <Widget>[
    //                                       TextButton(
    //                                         child: Text(
    //                                           'Yeah!',
    //                                           style: TextStyle(
    //                                               color: Colors.black,
    //                                               fontSize: 24,
    //                                               fontFamily: 'Salsa-Regular',
    //                                               fontWeight: FontWeight.w300),
    //                                         ),
    //                                         onPressed: () {
    //                                           markDone(
    //                                               schedules[index].title,
    //                                               schedules[index],
    //                                               schedules[index]
    //                                                   .id
    //                                                   .toString(),
    //                                               schedules[index].date);
    //                                           Navigator.of(context).pop();
    //                                         },
    //                                       ),
    //                                       TextButton(
    //                                         child: Text(
    //                                           'Nope',
    //                                           style: TextStyle(
    //                                               color: Colors.black,
    //                                               fontSize: 24,
    //                                               fontFamily: 'Salsa-Regular',
    //                                               fontWeight: FontWeight.w300),
    //                                         ),
    //                                         onPressed: () {
    //                                           Navigator.of(context).pop();
    //                                         },
    //                                       ),
    //                                     ],
    //                                   );
    //                                 },
    //                               ),
    //                               child: (schedules[index].isDone == 'true')
    //                                   ? GradientIcon(
    //                                       Icons.done_all,
    //                                       30.0,
    //                                       LinearGradient(
    //                                         colors: <Color>[
    //                                           Colors.yellow,
    //                                           Colors.pink,
    //                                           Colors.blue,
    //                                         ],
    //                                         begin: Alignment.topLeft,
    //                                         end: Alignment.bottomRight,
    //                                       ),
    //                                     )
    //                                   : Icon(Icons.done_all, size: 30),
    //                             ), // icon-1
    //                             InkWell(
    //                               onTap: () => showDialog<void>(
    //                                 context: context,
    //                                 barrierDismissible:
    //                                     false, // user must tap button!
    //                                 builder: (BuildContext context) {
    //                                   return AlertDialog(
    //                                     title: Text(
    //                                       'You just tapped the "Delete" button',
    //                                       style: TextStyle(
    //                                           fontSize: 28,
    //                                           fontFamily:
    //                                               'KaushanScript-Regular',
    //                                           fontWeight: FontWeight.w300),
    //                                     ),
    //                                     content: SingleChildScrollView(
    //                                       child: ListBody(
    //                                         children: <Widget>[
    //                                           Text(
    //                                             'Remove Event?',
    //                                             style: TextStyle(
    //                                                 color: Colors.black,
    //                                                 fontSize: 18,
    //                                                 fontFamily: 'Salsa-Regular',
    //                                                 fontWeight:
    //                                                     FontWeight.w300),
    //                                           ),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                     actions: <Widget>[
    //                                       TextButton(
    //                                         child: Text(
    //                                           'Yeah!',
    //                                           style: TextStyle(
    //                                               color: Colors.black,
    //                                               fontSize: 24,
    //                                               fontFamily: 'Salsa-Regular',
    //                                               fontWeight: FontWeight.w300),
    //                                         ),
    //                                         onPressed: () {
    //                                           deleteTx(schedules[index]
    //                                               .id
    //                                               .toString());
    //                                           Navigator.of(context).pop();
    //                                         },
    //                                       ),
    //                                       TextButton(
    //                                         child: Text(
    //                                           'Nope',
    //                                           style: TextStyle(
    //                                               color: Colors.black,
    //                                               fontSize: 24,
    //                                               fontFamily: 'Salsa-Regular',
    //                                               fontWeight: FontWeight.w300),
    //                                         ),
    //                                         onPressed: () {
    //                                           Navigator.of(context).pop();
    //                                         },
    //                                       ),
    //                                     ],
    //                                   );
    //                                 },
    //                               ),
    //                               child: GradientIcon(
    //                                 Icons.remove_circle_rounded,
    //                                 30.0,
    //                                 LinearGradient(
    //                                   colors: <Color>[
    //                                     Colors.yellow,
    //                                     Colors.pink,
    //                                     Colors.blue,
    //                                   ],
    //                                   begin: Alignment.topLeft,
    //                                   end: Alignment.bottomRight,
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       Card(
    //                         child: Padding(
    //                             padding: EdgeInsets.all(6),
    //                             // ignore: unrelated_type_equality_checks
    //                             child: (schedules[index].isDone == 'true')
    //                                 ? Text('Event Completed')
    //                                 : Text(
    //                                     'Scheduled For :  ${DateFormat.MMMd().format(DateTime.parse(schedules[index].date!))}')),
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //           itemCount: schedules.length,
    //         ),
    // );
    return Container(
      child: schedules.isEmpty
          ? Center(
              child: Text(
                'Chưa có công việc nào được tạo!',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            )
          : ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditSchedulesScreen(
                                  schedule: schedules[index])));
                      if (result != null) {
                        refresh();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: ColorConst.toDoTaskAppBarColor),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: ColorConst.toDoTaskAppBarColor),
                              ),
                              // borderRadius: BorderRadius.only(
                              //   bottomLeft: Radius.circular(18.0),
                              //   bottomRight: Radius.circular(18.0),
                              // ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0),
                                    child: Text(
                                      schedules[index].title ?? 'Updating',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Transform.scale(
                                  scale: 1.5,
                                  child: CustomCheckBox(
                                    value: schedules[index].isDone != 'false',
                                    onChanged: (value) {
                                      if (schedules[index].isDone != 'false') {
                                        markDone(schedules[index].id.toString(),
                                            'false');
                                      } else {
                                        markDone(schedules[index].id.toString(),
                                            'true');
                                      }
                                    },
                                    uncheckedFillColor: isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                    uncheckedIconColor: isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                    checkedFillColor: isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                    checkedIconColor:
                                        ColorConst.toDoTaskAppBarColor,
                                    borderColor: ColorConst.toDoTaskAppBarColor,
                                    shouldShowBorder: true,
                                    borderWidth: 1,
                                    borderRadius: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    child: Transform.scale(
                                      scale: 1.5,
                                      child: Icon(Icons.close,
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    onTap: () {
                                      deleteTx(schedules[index].id.toString());
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (schedules[index].note != null &&
                              schedules[index].note!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 8.0),
                              child: Text(
                                schedules[index].note ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 8.0),
                            child: Text(
                                'Ngày: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(schedules[index].date!))}',
                                overflow: TextOverflow.ellipsis),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Giờ nhắc: ',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(14.0)),
                                      border: Border.all(
                                          color:
                                              ColorConst.toDoTaskAppBarColor)),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      child: Text(
                                          '''${schedules[index].time != null ? '${schedules[index].time!.split(':')[0]}:${schedules[index].time!.split(':')[1]}' : ''}''')),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
