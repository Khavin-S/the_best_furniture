import 'package:flutter/material.dart';
import 'package:the_best_furniture/providers/screen_size.dart';

class MySnackBar {
  BuildContext context;
  MySnackBar({required this.context});
  void mySnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white,
        margin: EdgeInsets.only(
            bottom: ScreenSize.screenHeight - ScreenSize.screenHeight * 0.08,
            left: ScreenSize.screenWidth / 4,
            right: ScreenSize.screenWidth / 4),
        content: Text(
          text,
        ),
      ),
    );
  }
}

