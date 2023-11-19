import 'package:flutter/material.dart';
import 'package:the_best_furniture/pages/screen/admin_login_page.dart';
import 'package:the_best_furniture/pages/screen/user_login_page.dart';
import 'package:the_best_furniture/pages/screen/user_register_page.dart';
import 'package:the_best_furniture/providers/navigation.dart';
import 'package:the_best_furniture/providers/screen_size.dart';
import 'package:the_best_furniture/widgets/custom_button.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          Expanded(child: AuthenticationOption()),
          Expanded(child: BannerImage()),
        ],
      ),
    );
  }
}

class AuthenticationOption extends StatelessWidget {
  const AuthenticationOption({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to the best furniture',
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: MyButton(
              text: 'Create account',
              onPressed: () {
                Navigation.goto(context, const RegisterPage());
              },
              buttonColor: Colors.black,
              
            ),
          ),
          const SizedBox(
            height: 20,
          ),
           SizedBox(
          width: double.infinity,
          child: MyButton(
            text: 'Sign in',
            onPressed: () {
              Navigation.goto(context, const LoginPage());
            },
            buttonColor: Colors.white,
            textColor: Colors.black,
          ),
        ),
          const SizedBox(
            height: 20,
          ),
            Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigation.goto(context, const AdminLoginPage());
            },
            child: const Text(
              'Admin?',
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.deepPurple),
            ),
          ),
        ),
          const Text('Have a stable internet connection'),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'This is an ecommerce platform for buying furniture, We have all kinds in it. We do even provide custom furnitures for our customers, So, that our customer get satisfied with our products. Explore our products and support us. Thank you!',
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

class BannerImage extends StatelessWidget {
  const BannerImage({super.key});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/banner1.jfif',
      height: ScreenSize.screenHeight,
      width: ScreenSize.screenWidth,
      fit: BoxFit.cover,
    );
  }
}
