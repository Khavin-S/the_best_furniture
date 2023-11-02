import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  final FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  Future<bool> signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      return userCredential.user != null;
    } catch (e) {
      return false;
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }

  Future<bool> signUp() async {
    try{
    await _auth.createUserWithEmailAndPassword(
        email: email!, password: password!);   
    int count= await getTotalUserCount();
    count++;
    await userCollection.doc('#USER$count').set({'name': name,'email': email,'id': '#User$count' , 'address': address,'number': number,'password': password});
    await userCollection.doc('User count').set({'count':count});
    return true;
    }
    catch(e){
      return false;
    }
  }

    Future<int> getTotalUserCount() async {
    var totalcountsnapshot = await userCollection.doc('User count').get();
    return await totalcountsnapshot.get("count");
  }
}
