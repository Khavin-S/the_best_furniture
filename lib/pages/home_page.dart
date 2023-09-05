import 'package:flutter/material.dart';
import '../Global.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Padding(
        padding:
            EdgeInsets.only(left: screenWidth / 3, right: screenHeight / 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ElevatedButton(onPressed: () {}, child: Text('Logout'))],
        ),
      );
}
