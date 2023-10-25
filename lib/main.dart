import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_best_furniture/classes/admin.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Best Furniture',
      home: Scaffold(
          body: ElevatedButton(
              onPressed: () => Admin().addCategories(
                  "Chairs", "Stylish chairs for various purposes."),
              child: const Text("Addcategory"))),
    );
  }

  Future<File?> pickImageForProduct() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      print("No file selected");
    }
  }
}
