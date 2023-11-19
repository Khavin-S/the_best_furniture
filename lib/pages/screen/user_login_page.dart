import 'package:flutter/material.dart';
import 'package:the_best_furniture/models/user.dart';
import 'package:the_best_furniture/pages/screen/authentication_page.dart';
import 'package:the_best_furniture/pages/screen/products_page.dart';
import 'package:the_best_furniture/providers/navigation.dart';
import 'package:the_best_furniture/widgets/custom_button.dart';
import 'package:the_best_furniture/widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Row(
        children: [
          Expanded(child: LoginSection()),
          const Expanded(child: BannerImage()),
        ],
      ),
    );
  }
}

class LoginSection extends StatelessWidget {
   LoginSection({super.key});
   User user= User();
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
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
          child: MyTextField(
              hintText: 'Enter your email', controller: emailController),
        ),
          const SizedBox(
            height: 20,
          ),
             SizedBox(
          width: double.infinity,
          child: MyTextField(
              hintText: 'Enter your password', controller: passwordController),
        ),
          const SizedBox(
            height: 20,
          ),
           SizedBox(
          width: double.infinity,
          child: MyButton(
            text: 'Sign in',
            onPressed: ()async {
              
             String result = await user.signIn(emailController.text, passwordController.text);
              if(result.isEmpty){
               var username = User.name;
               print(username);
                Navigation.goto(context, ProductsPage());

              }
             
            },
            buttonColor: Colors.black,
          ),
        ),
          const SizedBox(
            height: 20,
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