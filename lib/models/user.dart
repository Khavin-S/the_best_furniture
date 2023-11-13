import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_best_furniture/models/collections%20and%20documents.dart';
import 'package:the_best_furniture/models/counts.dart';
import 'package:the_best_furniture/models/productservice.dart';

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


  Future<void> addToCart(String userId, String productId) async {
    await Collections.usersCollection
        .doc(userId)
        .collection('cart')
        .doc(productId)
        .set({'productId': productId});
  }
}
