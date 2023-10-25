import 'package:firebase_auth/firebase_auth.dart';

class User {
  String id;
  String name;
  String email;
  String password;
  String address;
  String number;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.number,
  });

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }

  Future signOut() async {
    await _auth.signOut();
  }

  Future signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
