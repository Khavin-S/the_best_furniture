import 'package:flutter/material.dart';
import 'package:the_best_furniture/models/admin.dart';
import 'package:the_best_furniture/pages/screen/authentication_page.dart';
import 'package:the_best_furniture/pages/screen/dashboard_page.dart';
import 'package:the_best_furniture/providers/navigation.dart';
import 'package:the_best_furniture/widgets/custom_button.dart';
import 'package:the_best_furniture/widgets/custom_textfield.dart';

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Row(
        children: [
          Expanded(child: AdminLoginSection()),
           const Expanded(child: BannerImage()),
        ],
      ),
    );
  }
}

class AdminLoginSection extends StatelessWidget {
   AdminLoginSection({super.key});
   Admin user= Admin();
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
              
           bool istrue = Admin().login(passwordController.text);
            if(istrue){
              Navigation.goto(context, const DashboardPage());
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