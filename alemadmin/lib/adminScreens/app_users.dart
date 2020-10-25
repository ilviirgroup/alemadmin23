import 'package:flutter/material.dart';

class AppUsers extends StatefulWidget {
  static const String id = 'Пользователи';
  @override
  _AppUsersState createState() => _AppUsersState();
}

class _AppUsersState extends State<AppUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Пользователи"),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }
}
