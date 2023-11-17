import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;
  int price;
  String category;
  String color;
  String description;
  String image;
  int stock;
  Timestamp createdTime;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.color,
    required this.description,
    required this.image,
    required this.stock,
    required this.createdTime,
  });

  factory Product.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: data['id'],
      name: data['name'],
      price: data['price'],
      category: data['category'],
      color: data['color'],
      description: data['description'],
      image: data['image'],
      stock: data['stock'],
      createdTime: data['createdTime']
    );
  }
}