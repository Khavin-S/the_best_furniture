import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1500836780023-c28f6f938b2c',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              color: Colors.black54,
              colorBlendMode: BlendMode.srcOver,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text(
                    'Login',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                 ),
                 SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Container(
                        color: Colors.white,
                        child: Form(
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                 labelText: 'Email',
                                 border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                decoration: InputDecoration(
                                 labelText: 'Password',
                                 border: OutlineInputBorder(),
                                ),
                                obscureText: true,
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                 // Navigate to registration screen
                                },
                                child: Text('Don\'t have an account? Sign up'),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                 // Handle login
                                },
                                child: Text('Login'),
                               
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                 ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
 }
}