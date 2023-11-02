import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:the_best_furniture/classes/user.dart';
import 'package:the_best_furniture/classes/widegts.dart';
import 'package:the_best_furniture/pages/loginpage.dart';

class RegisterPage extends StatelessWidget{
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body: Center(
        child: RegisterCard(),
      )
      ,
    );
  }
}

class RegisterCard extends StatelessWidget{
    TextEditingController nameController= TextEditingController();
    TextEditingController emailController= TextEditingController();
    TextEditingController passwordController= TextEditingController();
    TextEditingController addressController= TextEditingController();
    TextEditingController numberController= TextEditingController();
   RegisterCard({super.key});
    @override
  Widget build(BuildContext context){
    return Card(
      elevation: 5,
      child: SizedBox(
        height: ScreenSize.screenHeight / 1.7,
        width: ScreenSize.screenWidth / 4,
        child: Padding(padding: EdgeInsets.all(ScreenSize.screenHeight * 0.05,),child:  Column(
          children: [
                          const Text(
                "Register here",
                style: MyTextStyles.titleTextStyle,
              ),
          TextFormField(
            controller: nameController,
              decoration: const InputDecoration(
                  labelText: 'name',
                ),
 
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
          TextFormField(
            controller: addressController,
                          decoration: const InputDecoration(
                  labelText: 'address',
                ),
          ),
          TextFormField(
            controller: numberController,
                          decoration: const InputDecoration(
                  labelText: 'phone number',
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly

],

          ),
                        SizedBox(height: ScreenSize.screenHeight * 0.03),

          SizedBox(
            width: double.infinity,
            child: MyButton(text: 'Register', onPressed: (){handleUserRegister(context);}))
          ],
        ),),
      ),
    );
  }
 
  void handleUserRegister(BuildContext context) async{
    if(nameController.text!="" && emailController.text!="" && passwordController.text!="" && addressController.text!="" && numberController.text!=""){      
    bool isSignedUp=  await User(name: nameController.text,email: emailController.text,password: passwordController.text,address: addressController.text,number: numberController.text).signUp();
    if(isSignedUp==true){
          // ignore: use_build_context_synchronously
          Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      MySnackBar(context: context).mySnackBar('Your profile registered successfully');
    }
    }
  }
}