import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          
        ],
      ),
    );
  }
}
