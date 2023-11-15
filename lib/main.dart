import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_best_furniture/pages/product_screen.dart';
import 'package:the_best_furniture/providers/screen_size.dart';
import 'package:the_best_furniture/pages/product_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
  apiKey: "AIzaSyDnN8ekjR-otOcolqo1p6f-kVRGFAXPXuY",
  authDomain: "ecommerce-furniture-23681.firebaseapp.com",
  projectId: "ecommerce-furniture-23681",
  storageBucket: "ecommerce-furniture-23681.appspot.com",
  messagingSenderId: "770576114352",
  appId: "1:770576114352:web:b29251d9d526ec647c9175"
  ),
  );
  FirebaseAuth.instance.signOut();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,   
        theme: ThemeData(
          primarySwatch: Colors.deepPurple
        ),
        darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
        title: 'The best furniture',
        home:  ProductPage());
  }
}

class FirstPageDecider extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return const Scaffold(
        body: /*StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context, snapshot) {
          if(snapshot.hasData){
            return  HomePage();
          }
          else{
            return AuthPage();
          }
        })*/
      ProductScreen());
  }
}