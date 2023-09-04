import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_best_furniture/pages/home_page.dart';
import 'package:the_best_furniture/pages/login_page.dart';
import 'Global.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    // these are variable
    // for each firebase project
    apiKey: "AIzaSyD5CeMRxoR8CGVkDC7E5kC1ttAN8HHYreg",
    authDomain: "flutter-web-4a4ec.firebaseapp.com",
    projectId: "flutter-web-4a4ec",
    storageBucket: "flutter-web-4a4ec.appspot.com",
    messagingSenderId: "248879915947",
    appId: "1:248879915947:web:b1b1c8084e95174b21a8ee",
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
