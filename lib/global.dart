import 'package:flutter/material.dart';

class Navigation{
static void goto(BuildContext context,Widget page){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
}
  static void goback(BuildContext context) {
    Navigator.pop(context);
  }
}
