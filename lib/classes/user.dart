import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_best_furniture/classes/collections%20and%20documents.dart';
import 'package:the_best_furniture/classes/counts.dart';
import 'package:the_best_furniture/classes/product.dart';
import 'package:the_best_furniture/classes/productservice.dart';
import 'package:the_best_furniture/others/widegts.dart';
import 'package:the_best_furniture/pages/user/productpage.dart';

class User{
  String? id;
  String? name;
  String? email;
  String? password;
  String? address;
  String? number;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.address,
    this.number,
  });

  final FirebaseAuth auth = FirebaseAuth.instance;
  var productService = ProductService(); 
  Future<bool> signIn() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      return userCredential.user != null;
    } catch (e) {
      return false;
    }
  }

  Future signOut() async {
    await auth.signOut();
  }

  Future<bool> signUp() async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      int count = await (GetCounts.getTotalUserCount()) + 1;
      await Collections.usersCollection.doc('#USER$count').set({
        'name': name,
        'email': email,
        'id': '#USER$count',
        'address': address,
        'number': number,
        'password': password
      });
      await SetCount.updateUserCount(count);
      return true;
    } catch (e) {
      return false;
    }
  }

  Widget viewProduct() {
    ProductService _productService = ProductService();
    return StreamBuilder<List<Product>>(
      stream: _productService.getProductStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
            'No products available.',
           
          ));
        }
        final products = snapshot.data!;
        return GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: ((ScreenSize.screenWidth * 0.2) /
                (ScreenSize.screenHeight * 0.5)),
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(product: product,index: index);
          },
        );
      },
    );
  }

  Future<void> addToCart(String userId, String productId) async {
    await Collections.usersCollection
        .doc(userId)
        .collection('cart')
        .doc(productId)
        .set({'productId': productId});
  }
}
