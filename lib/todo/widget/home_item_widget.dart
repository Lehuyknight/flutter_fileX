//importing packages
import 'package:flutter_filex/helpers/ColorConst.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Defining Opt1()
// It has reference to ToDo() i.e. the To-Do List

class HomeItemWidget extends StatelessWidget {
  final Image iconImage;
  final String title;
  final Widget destinationRoute;
  HomeItemWidget(
      {required this.iconImage,
      required this.title,
      required this.destinationRoute});
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    //InkWell adds the onTap() functionality to Opt1(),
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return destinationRoute;
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
                child: iconImage,
              ),
              Expanded(
                flex: 3,
                //the column containing button and card
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            title,
                            style: TextStyle(
                                fontSize: 18,
                                color:
                                    !isDarkMode ? Colors.black : Colors.white),
                          ),
                        ),
                      ],
                    ),
                    // Expanded(
                    //   flex: 3,
                    //   child: Row(
                    //     //the card
                    //     children: [
                    //       Expanded(
                    //         child: Card(
                    //           child: Padding(
                    //             padding: EdgeInsets.all(8),
                    //             child: Text(
                    //               'Tạo ghi chú',
                    //               style: TextStyle(
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.w300),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Spacer(
                    //   flex: 1,
                    // ),
                  ],
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: !isDarkMode ? Colors.white : Colors.black,
            border:
                Border.all(color: ColorConst.toDoTaskAppBarColor, width: 0.5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0),
              bottomRight: Radius.circular(14.0),
            ),
          ),
        ),
      ),
    );
  }
}
