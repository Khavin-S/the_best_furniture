import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_best_furniture/providers/screen_size.dart';
import 'package:the_best_furniture/screens/auth_screen.dart';
import 'package:the_best_furniture/screens/product_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyC149qYLlQesce6TsDH8y6khPsztJ1Sqeg",
        authDomain: "the-best-furniture-52bee.firebaseapp.com",
        projectId: "the-best-furniture-52bee",
        storageBucket: "the-best-furniture-52bee.appspot.com",
        messagingSenderId: "839822430887",
        appId: "1:839822430887:web:e099b46c1aa1e81d260182",
        measurementId: "G-D4STXV438G"),
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
        home: AuthScreen());
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