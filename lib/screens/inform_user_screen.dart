import 'package:flutter/material.dart';

class InformUser extends StatefulWidget {
  @override
  _InformUserState createState() => _InformUserState();
}

class _InformUserState extends State<InformUser> {
  start() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Thông báo',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh_sharp,
            ),
            onPressed: () {
              start();
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[],
      ),
    );
  }
}
