import 'package:flutter/material.dart';
import 'package:the_best_furniture/classes/widgets/myscreensize.dart';
import 'package:the_best_furniture/classes/widgets/mytextstyle.dart';

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
