import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String name;
  Category({required this.name});

  factory Category.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Category(
      name: data['name'],
    );
  }
}
