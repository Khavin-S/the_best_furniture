import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_best_furniture/models/collections%20and%20documents.dart';

class User {
  static String id = "";
  static String name = "";
  static String email = "";
  static String password = "";
  static String address = "";
  static String number = "";
  final FirebaseAuth _authentication = FirebaseAuth.instance;

  Future<String> signIn(String receiveEmail, String receivePassword) async {
    try {
      User.email = receiveEmail;
      User.password = receivePassword;
      await _authentication.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await updateUserInformation(receiveEmail);
      return '';
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.code;
    }
  }

  Future<void> updateUserInformation(String userEmail) async {
    QuerySnapshot query = await Collections.usersCollection
        .where('email', isEqualTo: userEmail)
        .get();
    if (query.docs.isNotEmpty) {
      String docId = query.docs.first.id;
      DocumentSnapshot doc = await Collections.usersCollection.doc(docId).get();
      if (doc.exists) {
        id = doc.get('id');
        name = doc.get('name');
        email = doc.get('email');
        password = doc.get('password');
        number = doc.get('number');
        address = doc.get('address');
      } else {
        print(
            'Document does not exist in userCartCollection for email: $userEmail');
      }
    } else {
      print('No matching document found for email: $email');
    }
  }

  Future signOut() async {
    await _authentication.signOut();
  }

  Future<String> signUp(String name, String email, String password) async {
    try {
      await _authentication.createUserWithEmailAndPassword(
          email: email, password: password);
      DocumentSnapshot snapshot = await Documents.usersCount.get();
      int userCount = snapshot['count'] + 1;
      int userIdCount = snapshot['count_id'] + 1;
      //DateTime serverTime = DateTime.now();
      await Collections.usersCollection.doc('#user$userIdCount').set({
        'name': name,
        'email': email,
        'id': '#user$userIdCount',
        'address': address,
        'number': number,
        'password': password,
        'createdTime': FieldValue.serverTimestamp(),
      });
      await Documents.usersCount.set({
        'count': userCount,
        'count_id': userIdCount,
      });
      return '';
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  /* Future<void> addToCart(String productId) async {
    if (userId != null) {
      await Collections.usersCollection
          .doc(userId)
          .collection('cart')
          .doc(productId)
          .set({'productId': productId});
      print('Product added to the cart.');
    } else {
      // Handle the case where the user is not signed in
    }
  }

  /* Future<void> orderProduct(String userId, String productId) async {
    await Collections.usersCollection
        .doc(userId)
        .collection('orders')
        .doc(productId)
        .set({'productId': productId});
            // Add the product to the order collection
        Timestamp timestamp = Timestamp.now();
        String orderId = userId! + '_' + timestamp.millisecondsSinceEpoch.toString();

        await Collections.ordersCollection.doc(orderId).set({
          'userId': userId,
          'productId': productId,
          'orderTime': timestamp,
        });
  }*/

  final StreamController<List<Map<String, dynamic>>> _cartItemsController =
      StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get cartItemsStream =>
      _cartItemsController.stream;
  Future<List<Map<String, dynamic>>> getCartItems() async {
    if (userId != null) {
      try {
        QuerySnapshot cartSnapshot = await Collections.usersCollection
            .doc('userId')
            .collection('cart')
            .get();

        List<Map<String, dynamic>> cartItems = [];
        for (QueryDocumentSnapshot doc in cartSnapshot.docs) {
          String productId = doc['productId'];
          // Retrieve additional product details from your 'products' collection
          DocumentSnapshot productSnapshot =
              await Collections.productsCollection.doc(productId).get();
          if (productSnapshot.exists) {
            Map<String, dynamic> item = {
              'productId': productId,
              'productName': productSnapshot['productName'],
              'productPrice': productSnapshot['productPrice'],
              // Add any other product details you need
            };
            cartItems.add(item);
          }
        }

        return cartItems;
      } catch (e) {
        // Handle errors
        print('Error getting cart items: $e');
        return [];
      }
    } else {
      // Handle the case where the user is not signed in
      print('User not signed in.');
      return [];
    }
  }*/
}
