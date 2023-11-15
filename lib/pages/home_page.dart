import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_best_furniture/models/product.dart';
import 'package:the_best_furniture/models/productservice.dart';
import 'package:the_best_furniture/providers/screen_size.dart';
import 'package:the_best_furniture/widgets/custom_textstyle.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductService productService = ProductService();
  String selectedCategory = 'All';
  String searchQuery = '';
  String selectedColor = 'All';
  double selectedPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children:[
        const Expanded(
          flex: 1,
          child: Text(""),
        ),
        Expanded(
          flex: 3,
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
            return ProductItem(product: product, index: index);
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

        ]
       
      )
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final int index;
  ProductItem({required this.product, required this.index});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
crossAxisAlignment: CrossAxisAlignment.start,        children: [
          Expanded(
            flex: 6,
            child: Image.network(
              product.image,
              height: ScreenSize.screenHeight/3,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(product.name,style: MyTextStyle.subtitleStyle),
                      Text('₹ ${product.price}',style: MyTextStyle.subtitleStyle),
                    ],
                  ),
                  IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.cartShopping))
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}