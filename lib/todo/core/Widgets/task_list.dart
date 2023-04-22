// importing core packages
import 'package:flutter_filex/helpers/ColorConst.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:custom_check_box/custom_check_box.dart';
import '../Models/Task.dart';

//defining TransactionList as a stateless widget

class TasksList extends StatelessWidget {
  // instantiating a List of type Transaction names transactions
  final List<Task> tasks;
  //instantiating a function names deleteTx
  final Function deleteTx;
  final Function markDone;
  final Function markUndone;

  //a constructor that takes transactions and deleteTx as parameters
  TasksList(this.tasks, this.deleteTx, this.markDone, this.markUndone);

  //the build method
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    if (kDebugMode) {
      tasks.forEach((element) {
        print(
            '_alexTR_logging_: TasksList : build : task : id : ${element.id} : title : ${element.title} : isDone : ${element.isDone}');
      });
    }
    return Container(
      child: tasks.isEmpty
          ? Center(
              child: Text(
                'Chưa có ghi chú nào được tạo!',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            )
          //the listView builder
          : ListView.builder(
              // reverse: true,
              // itemBuilder parameter takes context and index
              itemBuilder: (ctx, index) {
                //returning the element
                // return Padding(
                //   padding: EdgeInsets.all(9),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       border: Border.all(color: Colors.black, width: 4),
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(15.0),
                //         topRight: Radius.circular(15.0),
                //         bottomRight: Radius.circular(15.0),
                //         bottomLeft: Radius.circular(15.0),
                //       ),
                //     ),
                //     child: Card(
                //       elevation: 5,
                //       margin: EdgeInsets.symmetric(
                //         vertical: 8,
                //         horizontal: 5,
                //       ),
                //       child: ListTile(
                //         leading: Icon(
                //           Icons.chevron_right,
                //           size: 40.0,
                //         ),
                //         title: Text(
                //           tasks[index].title ?? 'Updating',
                //           style: TextStyle(
                //               decoration: (tasks[index].isDone == 'true' ||
                //                       tasks[index].isDone == '1')
                //                   ? TextDecoration.lineThrough
                //                   : null,
                //               fontSize: 21,
                //               fontFamily: 'Salsa-Regular',
                //               fontWeight: FontWeight.w300),
                //         ),
                //         trailing: Wrap(
                //           spacing: 12, // space between two icons
                //           children: <Widget>[
                //             InkWell(
                //               onTap: () => showDialog<void>(
                //                 context: context,
                //                 barrierDismissible:
                //                     false, // user must tap button!
                //                 builder: (BuildContext context) {
                //                   return AlertDialog(
                //                     title: Text(
                //                       'You just tapped the "Done" button',
                //                       style: TextStyle(
                //                           fontSize: 28,
                //                           fontFamily: 'KaushanScript-Regular',
                //                           fontWeight: FontWeight.w600),
                //                     ),
                //                     content: SingleChildScrollView(
                //                       child: ListBody(
                //                         children: <Widget>[
                //                           Text(
                //                             'Mark the Task as "Done"?',
                //                             style: TextStyle(
                //                                 fontSize: 18,
                //                                 fontFamily: 'Salsa-Regular',
                //                                 fontWeight: FontWeight.w300),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                     actions: <Widget>[
                //                       TextButton(
                //                         child: Text(
                //                           'Yeah!',
                //                           style: TextStyle(
                //                               color: Colors.black,
                //                               fontSize: 24,
                //                               fontFamily: 'Salsa-Regular',
                //                               fontWeight: FontWeight.w300),
                //                         ),
                //                         onPressed: () {
                //                           markDone(
                //                             tasks[index].title,
                //                             tasks[index],
                //                             tasks[index].id.toString(),
                //                           );
                //                           Navigator.of(context).pop();
                //                         },
                //                       ),
                //                       TextButton(
                //                         child: Text(
                //                           'Nope',
                //                           style: TextStyle(
                //                               color: Colors.black,
                //                               fontSize: 24,
                //                               fontFamily: 'Salsa-Regular',
                //                               fontWeight: FontWeight.w300),
                //                         ),
                //                         onPressed: () {
                //                           Navigator.of(context).pop();
                //                         },
                //                       ),
                //                     ],
                //                   );
                //                 },
                //               ),
                //               child: ((tasks[index].isDone == 'true' ||
                //                       tasks[index].isDone == '1'))
                //                   ? Icon(
                //                       Icons.done_all,
                //                       size: 30.0,
                //                       color: Colors.green,
                //                     )
                //                   : Icon(Icons.done_all, size: 30),
                //             ), // icon-1
                //             InkWell(
                //               onTap: () => showDialog<void>(
                //                 context: context,
                //                 barrierDismissible:
                //                     false, // user must tap button!
                //                 builder: (BuildContext context) {
                //                   return AlertDialog(
                //                     title: Text(
                //                       'You just tapped the "Delete" button',
                //                       style: TextStyle(
                //                           fontSize: 28,
                //                           fontFamily: 'KaushanScript-Regular',
                //                           fontWeight: FontWeight.w600),
                //                     ),
                //                     content: SingleChildScrollView(
                //                       child: ListBody(
                //                         children: <Widget>[
                //                           Text(
                //                             'You wanna remove the task?',
                //                             style: TextStyle(
                //                                 fontSize: 18,
                //                                 fontFamily: 'Salsa-Regular',
                //                                 fontWeight: FontWeight.w300),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                     actions: <Widget>[
                //                       TextButton(
                //                         child: Text(
                //                           'Yeah!',
                //                           style: TextStyle(
                //                               color: Colors.black,
                //                               fontSize: 24,
                //                               fontFamily: 'Salsa-Regular',
                //                               fontWeight: FontWeight.w300),
                //                         ),
                //                         onPressed: () {
                //                           deleteTx(tasks[index].id.toString());
                //                           Navigator.of(context).pop();
                //                         },
                //                       ),
                //                       TextButton(
                //                         child: Text(
                //                           'Nope',
                //                           style: TextStyle(
                //                               color: Colors.black,
                //                               fontSize: 24,
                //                               fontFamily: 'Salsa-Regular',
                //                               fontWeight: FontWeight.w300),
                //                         ),
                //                         onPressed: () {
                //                           Navigator.of(context).pop();
                //                         },
                //                       ),
                //                     ],
                //                   );
                //                 },
                //               ),
                //               child: Icon(
                //                 Icons.remove_circle_rounded,
                //                 size: 30.0,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // );
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: tasks[index].notes != null &&
                          tasks[index].notes!.isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorConst.toDoTaskAppBarColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.0)),
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
                                          tasks[index].title ?? 'Updating',
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
                                        value: tasks[index].isDone != 'false',
                                        onChanged: (value) {
                                          if (tasks[index].isDone != 'false') {
                                            markUndone(tasks[index].title,
                                                tasks[index].id);
                                          } else {
                                            markDone(tasks[index].title,
                                                tasks[index].id);
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
                                        borderColor:
                                            ColorConst.toDoTaskAppBarColor,
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
                                          deleteTx(tasks[index].id.toString());
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  tasks[index].notes ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorConst.toDoTaskAppBarColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.0)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22.0),
                                  child: Text(
                                    tasks[index].title ?? 'Updating',
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
                                  value: tasks[index].isDone != 'false',
                                  onChanged: (value) {
                                    if (tasks[index].isDone != 'false') {
                                      markUndone(
                                          tasks[index].title, tasks[index].id);
                                    } else {
                                      markDone(
                                          tasks[index].title, tasks[index].id);
                                    }
                                  },
                                  uncheckedFillColor:
                                      isDarkMode ? Colors.black : Colors.white,
                                  uncheckedIconColor:
                                      isDarkMode ? Colors.black : Colors.white,
                                  checkedFillColor:
                                      isDarkMode ? Colors.black : Colors.white,
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
                                    deleteTx(tasks[index].id.toString());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                );
              },
              //itemCount is the parameter that shows the length of the List
              itemCount: tasks.length,
            ),
    );
  }
}
