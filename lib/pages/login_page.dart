import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_best_furniture/Global.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth / 8, right: screenWidth / 8),
                  child: TextField(
                    controller: emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth / 8, right: screenWidth / 8),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth / 8, right: screenWidth / 8),
                  child: SizedBox(
                      height: screenHeight / 16,
                      width: screenWidth / 2,
                      child: ElevatedButton(
                        onPressed: signIn,
                        child: Text('SignIn'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            )),
                      )),
                )
              ],
            ),
          ),
        ],
      );

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
