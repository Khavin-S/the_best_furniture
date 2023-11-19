import 'package:flutter/material.dart';

class UpdateProductPage extends StatelessWidget {
  String productId;
  String productName;
  String productImage;
  String productCategory;
  String productColor;
  String productDescription;
  int productPrice;
  int productStock;

  UpdateProductPage(
      {super.key,
      required this.productId,
      required this.productCategory,
      required this.productColor,
      required this.productDescription,
      required this.productName,
      required this.productPrice,
      required this.productStock,
      required this.productImage});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
