import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  String? productId;
  CartPage({super.key,this.productId});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}