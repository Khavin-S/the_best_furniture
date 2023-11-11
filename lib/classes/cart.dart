import 'package:cloud_firestore/cloud_firestore.dart';

class Cart{
    String productId;
  Cart(
    {required this.productId});

  factory Cart.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Cart(
      productId: data['productId']
    );
  }
}