import 'package:cloud_firestore/cloud_firestore.dart';


class Collections {
  static CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  static CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  static CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');
  static CollectionReference reportsCollection =
      FirebaseFirestore.instance.collection('reports');
  static CollectionReference userCartCollection =  FirebaseFirestore.instance.collection('users').doc().collection('cart');
}

class Documents {
  static DocumentReference usersCount =
      Collections.reportsCollection.doc('user_count');
  static DocumentReference ordersCount =
      Collections.reportsCollection.doc('order_count');
  static DocumentReference liveordersCount =
      Collections.reportsCollection.doc('live_order_count');
  static DocumentReference productsCount =
      Collections.reportsCollection.doc('product_count');
}
