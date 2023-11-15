import 'package:flutter/material.dart';
import 'package:the_best_furniture/providers/screen_size.dart';

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
          title,style: TextStyle(color: Colors.black,fontSize: ScreenSize.screenHeight/20,fontWeight: FontWeight.bold),    
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
