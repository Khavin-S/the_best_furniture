import 'package:flutter/material.dart';

class UpdateProductPage extends StatefulWidget {
  String name;
  String color;
  String image;
  String category;
  String description;
  int price;
  int stock;
  
  UpdateProductPage(
      {super.key,
      required this.name,
      required this.color,
      required this.image,
      required this.category,
      required this.description,
      required this.price,
      required this.stock,
      });

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
    );
  }
}

