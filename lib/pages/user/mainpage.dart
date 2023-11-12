import 'package:flutter/material.dart';
import 'package:the_best_furniture/global.dart';
import 'package:the_best_furniture/mywidgets/button.dart';
import 'package:the_best_furniture/mywidgets/textfield.dart';
import 'package:the_best_furniture/others/widegts.dart';
import 'package:the_best_furniture/classes/user.dart';
import 'package:the_best_furniture/pages/user/homepage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _MainPageState();
}

class _MainPageState extends State<AuthPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  late String email;
  late String password;
  late String name;

  String currentContent = 'allContent';
  void changePage(String page) {
    setState(() {
      currentContent = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(ScreenSize.screenWidth / 15),
                  child: Column(
                    children: [
                      if (currentContent != 'allContent')
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              onPressed: () {
                                changePage('allContent');
                              },
                              icon: const Icon(Icons.arrow_back)),
                        ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Welcome to the best furniture',
                            style: TextStyle(
                                fontSize: ScreenSize.screenHeight / 20),
                          )),
                      SizedBox(
                        height: ScreenSize.screenHeight / 40,
                      ),
                      Container(
                        child: getContent(),
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              'Have a stable internet connection\n\nThis is an ecommerce platform for buying furniture, We have all kinds in it. We do even provide custom furnitures for our customers, So, that our customer get satisfied with our products. Explore our products and support us. Thank you!')),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/banners/Couches, Sofas & Loveseats.jfif',
                  height: ScreenSize.screenHeight,
                  width: ScreenSize.screenWidth / 2,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget getContent() {
    switch (currentContent) {
      case "signin":
        return signInContent();
      case "signup":
        return signupContent();
      case "admin":
        return adminSignInContent();
      default:
        return authContent();
    }
  }

  Widget authContent() {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          SizedBox(
            height: ScreenSize.screenHeight / 40,
          ),
          SizedBox(
            width: double.infinity,
            child: MyButton(
              text: 'Create account',
              onPressed: () {
                changePage('signup');
              },
              buttonColor: Colors.black,
            ),
          ),
          SizedBox(
            height: ScreenSize.screenHeight / 40,
          ),
          SizedBox(
            width: double.infinity,
            child: MyButton(
              text: 'Sign in',
              onPressed: () {
                changePage('signin');
              },
              buttonColor: Colors.white,
              textColor: Colors.black,
            ),
          ),
          SizedBox(
            height: ScreenSize.screenHeight / 40,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Admin?',
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.deepPurple),
                  ))),
          SizedBox(
            height: ScreenSize.screenHeight / 40,
          ),
        ],
      ),
    );
  }

  Widget signInContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: double.infinity,
            child: MyTextField(hintText: 'Enter your email', controller: emailController)),
        SizedBox(
          height: ScreenSize.screenHeight / 40,
        ),
        SizedBox(
            width: double.infinity,
            child: MyTextField(
              hintText: 'Enter your password',
              controller: passwordController,
            )),
        SizedBox(
          height: ScreenSize.screenHeight / 40,
        ),
        SizedBox(
          width: double.infinity,
          child: MyButton(
            text: 'Sign in',
            onPressed: () => handleUserSignIn(context),
            buttonColor: Colors.black,
          ),
        ),
        SizedBox(
          height: ScreenSize.screenHeight / 40,
        ),
      ],
    );
  }

  Widget signupContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: double.infinity,
            child: MyTextField(
                hintText: 'Enter your name', controller: nameController)),
        SizedBox(
          height: ScreenSize.screenHeight / 40,
        ),
        SizedBox(
            width: double.infinity,
            child: MyTextField(
              hintText: 'Enter your email',
              controller: emailController,
            )),
        SizedBox(
          height: ScreenSize.screenHeight / 40,
        ),
        SizedBox(
            width: double.infinity,
            child: MyTextField(
              hintText: 'Enter your password',
              controller: passwordController,
            )),
        SizedBox(
          height: ScreenSize.screenHeight / 40,
        ),
        SizedBox(
          width: double.infinity,
          child: MyButton(
            text: 'Create account',
            onPressed: () {
              handleUserRegister(context);
            },
            buttonColor: Colors.black,
          ),
        ),
        SizedBox(
          height: ScreenSize.screenHeight / 40,
        ),
      ],
    );
  }

  Widget adminSignInContent() {
    return const Column();
  }

  void handleUserSignIn(BuildContext context) async {
    email = emailController.text;
    password = passwordController.text;
    if (email != "" && password != "") {
      final bool signedIn =
          await User(email: email, password: password).signIn();
      if (signedIn) {
        Navigation.goto(context, HomePage());
      }
    } else {
      if (email == "" && password == "") {
      } else if (email != "" && password == "") {
      } else if (email == "" && password != "") {
      } else {}
    }
  }

  void handleUserRegister(BuildContext context) async {
    email = emailController.text;
    password = passwordController.text;
    name = nameController.text;
    if (name != "" && email != "" && password != "") {
      bool isSignedUp = await User(
              name: name,
              email: email,
              password: password,
              address: "",
              number: null)
          .signUp();
      if (isSignedUp) {
        changePage('allContent');
      }
    }
  }
}
