import 'package:flutter/material.dart';
import 'package:the_best_furniture/models/user.dart';
import 'package:the_best_furniture/pages/admin/dashboard_page.dart';
import 'package:the_best_furniture/pages/user/products_page.dart';
import 'package:the_best_furniture/providers/navigation.dart';
import 'package:the_best_furniture/providers/screen_size.dart';
import 'package:the_best_furniture/widgets/custom_button.dart';
import 'package:the_best_furniture/widgets/custom_textfield.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  late String email;
  late String password;
  late String name;
  String currentContent = 'auth';
  void changePage(String page) {
    setState(
      () {
        emailController = TextEditingController();
        passwordController = TextEditingController();
        nameController = TextEditingController();
        currentContent = page;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: ScreenSize.screenWidth / 15,
                right: ScreenSize.screenWidth / 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (currentContent != 'auth')
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          onPressed: () {
                            changePage('auth');
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ),
                  Text(
                    'Welcome to the best furniture',
                    style: TextStyle(fontSize: ScreenSize.screenHeight / 20),
                  ),
                  SizedBox(
                    height: ScreenSize.screenHeight / 40,
                  ),
                  Container(
                    child: getContent(),
                  ),
                  SizedBox(
                    height: ScreenSize.screenHeight / 40,
                  ),
                  const Text('Have a stable internet connection'),
                  SizedBox(
                    height: ScreenSize.screenHeight / 40,
                  ),
                  const Text(
                    'This is an ecommerce platform for buying furniture, We have all kinds in it. We do even provide custom furnitures for our customers, So, that our customer get satisfied with our products. Explore our products and support us. Thank you!',
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Image.asset(
              'assets/images/banner1.jfif',
              height: ScreenSize.screenHeight,
              width: ScreenSize.screenWidth,
              fit: BoxFit.cover,
            ),
          ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            onPressed: () {
              changePage('admin');
            },
            child: const Text(
              'Admin?',
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.deepPurple),
            ),
          ),
        ),
      ],
    );
  }

  Widget signInContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: double.infinity,
          child: MyTextField(
              hintText: 'Enter your email', controller: emailController),
        ),
        SizedBox(
          height: ScreenSize.screenHeight / 40,
        ),
        SizedBox(
          width: double.infinity,
          child: MyTextField(
            hintText: 'Enter your password',
            controller: passwordController,
          ),
        ),
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
              hintText: 'Enter your name', controller: nameController),
        ),
        SizedBox(
          height: ScreenSize.screenHeight / 40,
        ),
        SizedBox(
          width: double.infinity,
          child: MyTextField(
            hintText: 'Enter your email',
            controller: emailController,
          ),
        ),
        SizedBox(
          height: ScreenSize.screenHeight / 40,
        ),
        SizedBox(
          width: double.infinity,
          child: MyTextField(
            hintText: 'Enter your password',
            controller: passwordController,
          ),
        ),
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
      ],
    );
  }

  Widget adminSignInContent() {
    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            child: MyTextField(
                hintText: "Enter your password",
                controller: passwordController)),
        SizedBox(
          height: ScreenSize.screenHeight / 40,
        ),
        SizedBox(
          width: double.infinity,
          child: MyButton(
            text: 'Go to dashboard',
            onPressed: () {
              handleAdminLogin(context);
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

  void handleUserSignIn(BuildContext context) async {
    email = emailController.text;
    password = passwordController.text;
    if (email != "" && password != "") {
      final bool signedIn =
          await User(email: email, password: password).signIn();
      if (signedIn) {
        Navigation.goto(context, ProductPage());
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
              number: "")
          .signUp();
      if (isSignedUp) {
        changePage('auth');
      }
    }
  }

  void handleAdminLogin(BuildContext context) {
    String password = passwordController.text;
    if (password == '3-Feb-04') {
      Navigation.goto(context, Dashboard());
    }
  }
}
