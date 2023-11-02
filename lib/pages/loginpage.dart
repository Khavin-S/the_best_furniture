import 'package:flutter/material.dart';
import 'package:the_best_furniture/classes/user.dart';
import 'package:the_best_furniture/classes/widegts.dart';
import 'package:the_best_furniture/others/productpage.dart';
import 'package:the_best_furniture/pages/registerpage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: LoginCard()),
    );
  }
}

class LoginCard extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  LoginCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SizedBox(
        height: ScreenSize.screenHeight / 2,
        width: ScreenSize.screenWidth / 4,
        child: Padding(
          padding: EdgeInsets.all(ScreenSize.screenHeight * 0.05),
          child: Column(
            children: [
              const Text(
                "Great to see you again!",
                style: MyTextStyles.titleTextStyle,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'email',
                ),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'password',
                ),
              ),
              SizedBox(height: ScreenSize.screenHeight * 0.03),
              SizedBox(
                width: double.infinity,
                child: MyButton(
                    text: 'Login',
                    onPressed: () {
                      handleUserSignIn(context);
                    }),
              ),
                            SizedBox(height: ScreenSize.screenHeight * 0.03),

              TextButton(onPressed: (){      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegisterPage()),
      );}, child: const Text('Register'))
            ],
          ),
        ),
      ),
    );
  }

  void handleUserSignIn(BuildContext context) async{
    final bool signedIn = await User(
            email: emailController.text, password: passwordController.text)
        .signIn();
    if (signedIn == true) {
     // ignore: use_build_context_synchronously
     MySnackBar(context: context).mySnackBar('welcome');
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductPage()),
      );
    }
    else{
      if(emailController.text=="" && passwordController.text==""){
            // ignore: use_build_context_synchronously
            MySnackBar(context: context).mySnackBar('please enter your email and password!');
      }
      else if(emailController.text!="" && passwordController.text==""){
            // ignore: use_build_context_synchronously
            MySnackBar(context: context).mySnackBar('please enter your password!');
      }
      else if(emailController.text=="" && passwordController.text!=""){
            // ignore: use_build_context_synchronously
            MySnackBar(context: context).mySnackBar('please enter your email!');
      }
      else{
            // ignore: use_build_context_synchronously
            MySnackBar(context: context).mySnackBar('user not found! check your email and password');
      }
    }
  }
}
