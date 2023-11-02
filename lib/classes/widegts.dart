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
  final List<Widget>? actions;
  MyAppBar({required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
      actions: [
        TextButton(
            onPressed: () {},
            child: const Text(
              "Home",
              style: MyTextStyles.linkTextStyle,
            )),
        TextButton(
            onPressed: () {},
            child: const Text(
              "Products",
              style: MyTextStyles.linkTextStyle,
            )),
        TextButton(
            onPressed: () {},
            child: const Text(
              "Cart",
              style: MyTextStyles.linkTextStyle,
            )),
        IconButton(
            iconSize: 40,
            onPressed: () {},
            icon: const CircleAvatar(
              radius: 20,
            )),
      ],
    );
  }
}

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const MyButton({super.key, required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
      child: Text(text),
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
