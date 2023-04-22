import 'package:flutter/material.dart';

class ListTaskItem extends StatelessWidget {
  const ListTaskItem(
      {Key? key, required this.color, required this.note, required this.time})
      : super(key: key);
  final Color color;
  final String note;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            height: 20,
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(note, style: TextStyle(fontSize: 16)),
          ),
          Spacer(),
          Text(
            time,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
