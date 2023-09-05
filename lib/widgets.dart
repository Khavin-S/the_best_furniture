import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  bool showtext;
  final Controller = TextEditingController();
  InputField({required this.hint, this.showtext = false});
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: showtext,
      controller: Controller,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: hint,
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String ButtonText;
  final Color color;
  Button({required this.ButtonText, required this.color});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(ButtonText),
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          )),
    );
  }
}
