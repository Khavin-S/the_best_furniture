import 'package:flutter/material.dart';

class ScreenSize
{
    static late double screenWidth;
    static late double screenHeight;

    static void init(BuildContext context)
    {
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
          style: MyTextStyles.titleTextStyle,
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}


class MyGreyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
   MyGreyButton({super.key, required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
                        width: ScreenSize.screenWidth / 6,
              height: ScreenSize.screenHeight / 15,
              child: ElevatedButton(
                onPressed: () {
                  onPressed;
                },
                child: Text(text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 39, 39, 39),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
            );
  }
}
class MyBlueButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
   MyBlueButton({super.key, required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
             width: ScreenSize.screenWidth / 6,
              height: ScreenSize.screenHeight / 15,
              child: ElevatedButton(
                onPressed: () {
                  onPressed;
                },
                child: Text(text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 1, 35, 63),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
            );
  }
}

class MySnackBar{
BuildContext context;
MySnackBar({required this.context});
 void mySnackBar(String text){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white,
        margin: EdgeInsets.only(bottom:ScreenSize.screenHeight-ScreenSize.screenHeight*0.08 ,left: ScreenSize.screenWidth/4,right: ScreenSize.screenWidth/4),
        content: Text(
          text,
          style: MyTextStyles.commonTextStyle,
        ),
      ),
    );
 }
}
class MyTextStyles {
  static const TextStyle commonTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );
  static const TextStyle titleTextStyle =
      TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold);
  static const TextStyle linkTextStyle = TextStyle(fontSize: 16);
}
