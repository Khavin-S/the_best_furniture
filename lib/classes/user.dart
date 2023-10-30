import 'package:firebase_auth/firebase_auth.dart';

class User {
  String? id;
  String? name;
  String email;
  String password;
  String? address;
  String? number;

  User({
    this.id,
    this.name,
    required this.email,
    required this.password,
    this.address,
    this.number,
  });

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user != null;
    } catch (e) {
      return false;
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }

  Future signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
