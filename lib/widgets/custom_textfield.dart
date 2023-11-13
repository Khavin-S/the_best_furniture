import 'package:flutter/material.dart';
import 'package:the_best_furniture/providers/screen_size.dart';

class MyTextField extends StatelessWidget {
  TextEditingController controller =TextEditingController();
  String hintText;
  Icon? perfixIcon;
  Icon? suffixIcon;
  MyTextField({required this.hintText,required this.controller,this.perfixIcon,this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    return Container(
            width: ScreenSize.screenWidth / 3,
      height: ScreenSize.screenHeight / 15,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          
          prefix: perfixIcon,
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
        hintText: hintText,
        suffixIcon: suffixIcon
        ),
      ),
    );
  }
}