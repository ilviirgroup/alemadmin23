import 'dart:ui';

import 'package:flutter/material.dart';

class Successfull extends StatelessWidget {
  static const String id = 'successful';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal[600],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                color: Colors.teal[50],
                size: 50,
              ),
              SizedBox(height: 10.0),
              Text(
                'Successfully added!',
                style: TextStyle(
                  color: Colors.teal[50],
                  fontSize: 22.0,
                  letterSpacing: 2.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
