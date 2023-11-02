import 'package:flutter/material.dart';
import 'package:the_best_furniture/classes/product.dart';
import 'package:the_best_furniture/classes/productservice.dart';
import 'package:the_best_furniture/classes/widegts.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            MyAppBar(title: "THE BEST FURNITURE"),
          ],
          body: Card(
            margin: EdgeInsets.all(ScreenSize.screenWidth*0.2),
            child: Row(
              children: [
                Expanded(flex: 4, child: ProductGridSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ProductGridSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductService _productService = ProductService();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<List<Product>>(
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: ((ScreenSize.screenWidth * 0.2) /
                    (ScreenSize.screenHeight * 0.5)),
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(product: product);
              },
            );
          }),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({required this.product});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.blue,
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
