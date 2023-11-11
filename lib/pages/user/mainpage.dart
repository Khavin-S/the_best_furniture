
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
   MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String currentContent = 'allContent';
  void changePage(String page) {
    setState(() {
      currentContent = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  child: getContent(),
                ),
              ),
              Expanded(
             child: Text('IMAGE'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget getContent(){
  switch(currentContent){
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
Widget authContent(){
  return const Column(
    
  );
}

Widget signInContent(){
  return  const Column(

  );
}

Widget signupContent(){
  return  const Column(

  );
}

Widget adminSignInContent(){
  return const Column(

  );
}

}


