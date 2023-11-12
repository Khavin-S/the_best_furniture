import 'package:flutter/material.dart';
import 'package:the_best_furniture/pages/user/mainpage.dart';

class ScreenSize {
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}

class MyAppBar extends StatelessWidget {
  final String title;
  MyAppBar({required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliverAppBar(
        expandedHeight: ScreenSize.screenHeight * 0.1,
        elevation: 0,
        floating: true,
        pinned: false,
        snap: true,
        title: Text(
          title,
         
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}




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

