import 'package:flutter/material.dart';
import 'package:the_best_furniture/classes/product.dart';
import 'package:the_best_furniture/classes/productservice.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});
  @override
  Widget build(BuildContext context) {
    ProductService _productService = ProductService();

    return StreamBuilder<List<Product>>(
        stream: _productService.getProductStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No products available.');
          }
          final products = snapshot.data!;
          return GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.10,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(product: product);
            },
          );
        });
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({required this.product});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.red,
      child: Column(
        children: [
          Image.network(product.image),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name),
                Text("${product.price}"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
