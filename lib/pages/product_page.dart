import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_best_furniture/models/product.dart';
import 'package:the_best_furniture/models/productservice.dart';
import 'package:the_best_furniture/providers/screen_size.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductService productService = ProductService();
  String selectedCategory = 'All';
  String searchQuery = '';
  String selectedColor = 'All';
  double selectedPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          Expanded(
            child: StreamBuilder<List<Product>>(
              stream: productService.filterProducts(
                selectedCategory: selectedCategory,
                searchQuery: searchQuery,
                selectedColor: selectedColor,
                selectedPrice: selectedPrice,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<Product> products = snapshot.data!;
                  return GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: ((ScreenSize.screenWidth * 0.18) /
                (ScreenSize.screenHeight * 0.5)),
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(product: product, index: index);
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
            ),
          ),
        ],
      ),
    );
  }
}
/*

 ListView.builder(
                  
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(products[index].image),
                        title: Text(products[index].name),
                        subtitle: Text(
                          'Category: ${products[index].category}\n'
                          'Color: ${products[index].color}\n'
                          'Price: \$${products[index].price.toStringAsFixed(2)}',
                        ),
                      );
                    },
                  );
StreamBuilder<List<Product>>(
      stream: _productService.getProductStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
            'No products available.',
          ));
        }
        final products = snapshot.data!;
        return GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: ((ScreenSize.screenWidth * 0.18) /
                (ScreenSize.screenHeight * 0.5)),
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return 
            
            ProductCard(product: product, index: index);
          },
        );
      },
    );


     */
     class ProductCard extends StatelessWidget {
  final Product product;
  final int index;

  ProductCard({required this.product, required this.index});
  @override
  Widget build(BuildContext context) {
   return 
    Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: ScreenSize.screenHeight * 0.35,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(product.image), fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const FaIcon(FontAwesomeIcons.heart),
                    iconSize: 20,
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(alignment: Alignment.center, child: Text(product.name,style: TextStyle(fontWeight: FontWeight.bold),)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("₹ ${product.price}",style: TextStyle(fontWeight: FontWeight.bold),),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.deepPurple),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: (){}, icon: FaIcon(FontAwesomeIcons.cartShopping),iconSize: 20,),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
