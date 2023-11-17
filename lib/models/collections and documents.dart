import 'package:cloud_firestore/cloud_firestore.dart';

class Collections {
  //users
  static CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  //category
  static CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');
  //colors
  static CollectionReference colorsCollectionCollection =
      FirebaseFirestore.instance.collection('colors');
  //products
  static CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  //orders
  static CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('products');
  //report
  static CollectionReference reportsCollection =
      FirebaseFirestore.instance.collection('reports');
  //cart
  static CollectionReference userCartCollection =
      FirebaseFirestore.instance.collection('users').doc().collection('cart');
}

class Documents {
  //user count
  static DocumentReference usersCount =
      Collections.reportsCollection.doc('user_count');
  //order count
  static DocumentReference ordersCount =
      Collections.reportsCollection.doc('order_count');
  //live order count
  static DocumentReference liveordersCount =
      Collections.reportsCollection.doc('live_order_count');
  //total product count
  static DocumentReference productsCount =
      Collections.reportsCollection.doc('product_count');
}
