import 'package:cloud_firestore/cloud_firestore.dart';

class Categories {
  String name;
  String description;
  int count;
  Categories(
      {required this.name, required this.description, required this.count});

  factory Categories.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Categories(
      name: data['name'],
      description: data['description'],
      count: data['count'],
    );
  }
}
