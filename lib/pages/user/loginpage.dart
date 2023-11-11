import 'package:flutter/material.dart';
import 'package:the_best_furniture/classes/user.dart';
import 'package:the_best_furniture/global.dart';
import 'package:the_best_furniture/pages/user/homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          
        ],
      ),
    );
  }

  void handleUserSignIn(BuildContext context) async {
    if(email != "" && password != ""){
    final bool signedIn = await User(email: email,password: password)
        .signIn();
    if (signedIn) {
      Navigation.goto(context, HomePage());
    } 
    }
    else {
      if (email == "" && password == "") {
      } else if (email != "" && password == "") {
      } else if (email == "" && password != "") {
      } else {
      }
    }
  }
}
