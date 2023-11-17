import 'package:cloud_firestore/cloud_firestore.dart';

class Categories {
  String name;
  String slogan;
  int count;
  int count_id;
  Categories(
      {required this.name,
      required this.slogan,
      required this.count,
      required this.count_id});
  factory Categories.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Categories(
      name: data['name'],
      slogan: data['slogan'],
      count: data['count'],
      count_id: data['count_id'],
    );
  }
}
