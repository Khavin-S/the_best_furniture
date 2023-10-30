import 'package:flutter/material.dart';
import 'package:the_best_furniture/classes/user.dart';
import 'package:the_best_furniture/classes/widgets/myscreensize.dart';
import 'package:the_best_furniture/classes/widgets/mytextstyle.dart';
import 'package:the_best_furniture/pages/productpage.dart';

class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: LoginCard()),
    );
  }
}

class LoginCard extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
              SizedBox(height: ScreenSize.screenHeight * 0.02),
              SizedBox(
                width: double.infinity,
                child: Button(
                    text: 'Login',
                    onPressed: () {
                      handleUserSignIn(context);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleUserSignIn(BuildContext context) async {
    final bool signedIn = await User(
            email: emailController.text, password: passwordController.text)
        .signIn();
    if (signedIn == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductPage()),
      );
    }
  }
}

class Button extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  Button({required this.text, required this.onPressed});
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
