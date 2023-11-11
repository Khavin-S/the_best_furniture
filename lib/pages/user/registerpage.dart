import 'package:flutter/material.dart';
import 'package:the_best_furniture/classes/user.dart';
import 'package:the_best_furniture/global.dart';
import 'package:the_best_furniture/pages/user/loginpage.dart';

class RegisterPage extends StatefulWidget{
  
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  late String email;
  late String name;
  late String password;
  late String address;
  late String number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
   void handleUserRegister(BuildContext context) async{
    if(name!="" && email!="" && password!="" && address!="" && number!=""){      
    bool isSignedUp=  await User(name: name,email: email,password: password,address: address,number: number).signUp();
    if(isSignedUp){      
      Navigation.goto(context,LoginPage());
    }
    }
  }
}




