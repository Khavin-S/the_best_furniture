import 'dart:html';

import 'package:flutter/material.dart';

class Navigation {
  static void goto(context,object){
      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => object),
  );
   }
  static void goback(context){
       Navigator.pop(context);
   }
}
