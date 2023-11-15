import 'package:cloud_firestore/cloud_firestore.dart';

class ProductColors {
  String name;
  ProductColors(
  {required this.name});
  factory ProductColors.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductColors(
      name: data['name'],    
    );
  }
}
