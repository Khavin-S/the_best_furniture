import 'package:flutter/material.dart';
import 'package:the_best_furniture/providers/screen_size.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  Color? buttonColor;
  final Color? textColor;
   MyButton(
      {super.key, required this.text,required this.onPressed,required this.buttonColor,this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSize.screenWidth / 3,
      height: ScreenSize.screenHeight / 15,
      child: ElevatedButton(
        onPressed: 
        onPressed,
        onHover: (value) {
          buttonColor=Colors.deepPurple;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: Colors.black) 
          ),
        ),
        child: Text(text,style: TextStyle(color: textColor ),),
      ),
    );
  }
}