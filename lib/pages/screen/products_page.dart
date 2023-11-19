import 'package:flutter/material.dart';
import 'package:the_best_furniture/models/product.dart';
import 'package:the_best_furniture/models/productservice.dart';
import 'package:the_best_furniture/providers/screen_size.dart';
import 'package:the_best_furniture/widgets/custom_textstyle.dart';

class ProductsPage extends StatelessWidget {
  TextEditingController searchQueryController = TextEditingController();
  ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ProductSection(),
      )
    );
  }
}

class ProductSection extends StatelessWidget {
  ProductService _productService = ProductService();
  ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedMinPrice = 0;
    int selectedMaxPrice = 100000;
    String selectedColor = '';
    String selectedCategory = '';
    String searchQuery = '';
    bool isSortByNewest = false;
    return StreamBuilder<List<Product>>(
      stream: _productService.getProductStream(
        minPrice: selectedMinPrice,
        maxPrice: selectedMaxPrice,
        color: selectedColor,
        category: selectedCategory,
        searchQuery: searchQuery,
        sortByNewest: isSortByNewest
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Product> category = snapshot.data!;
          return GridView.builder(
            itemCount: category.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: ((ScreenSize.screenWidth * 0.18) /
                  (ScreenSize.screenHeight * 0.5)),
            ),
            itemBuilder: (context, index) {
              final product = category[index];
              return ProductCard(product: product);
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}


class ProductCard extends StatelessWidget {
  Product product;
  ProductCard({required this.product});
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
        //
        },
        child: Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 4,
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    product.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: MyTextStyle.bodyStyle,
                    ),
                    Text('\u{20B9}' '${product.price}',
                        style: MyTextStyle.bodyStyle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
