import 'package:flutter/material.dart';
import 'package:the_best_furniture/widgets.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Image.asset('assets/images/download (35).jfif',
                fit: BoxFit.fill),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputField(hint: 'Email', showtext: true),
                InputField(hint: 'Password', showtext: true),
                Button(ButtonText: "Sign In", color: Colors.black),
              ],
            ),
          ),
        ],
      );
}
