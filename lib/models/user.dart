import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_best_furniture/models/collections%20and%20documents.dart';
import 'package:the_best_furniture/models/counts.dart';
import 'package:the_best_furniture/models/productservice.dart';

class User {
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
  String? get userId => id;

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
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');


  Future signOut() async {
    await auth.signOut();
  }

  Future<bool> signUp() async {
    try {
      await auth.createUserWithEmailAndPassword(
      email: email!, password: password!);
      int count = await (GetCounts.getTotalUserCount()) + 1;
      int countId = await (GetCounts.getTotalUserIdCount()) + 1;
      DateTime serverTime = DateTime.now();
      await Collections.usersCollection.doc('#USER$countId').set({
        'name': name,
        'email': email,
        'id': '#USER$countId',
        'address': address,
        'number': number,
        'password': password,
        'createdTime': FieldValue.serverTimestamp(),
      });
      await SetCount.updateUserCount(count);
      await SetCount.updateUserIdCount(countId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> addToCart(String userId, String productId) async {
    if (userId != null) {
      await Collections.usersCollection
          .doc(userId)
          .collection('cart')
          .doc(productId)
          .set({'productId': productId});
    } else {
      // Handle the case where the user is not signed in
    }
  }

  Future<void> orderProduct(String userId, String productId) async {
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
  }
}
