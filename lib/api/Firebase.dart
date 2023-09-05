import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_best_furniture/Global.dart';

class Firebase {
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmail.trim(), password: userPassword.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
