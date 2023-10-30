import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_best_furniture/classes/widgets/myscreensize.dart';
import 'package:the_best_furniture/pages/productpage.dart';

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
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Best Furniture',
        theme: ThemeData(fontFamily: 'Kanit'),
        home: ProductPage());
  }
}
