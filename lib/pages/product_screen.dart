import 'package:flutter/material.dart';
import 'package:the_best_furniture/models/category.dart';
import 'package:the_best_furniture/models/colors.dart';
import 'package:the_best_furniture/models/product.dart';
import 'package:the_best_furniture/models/productservice.dart';
import 'package:the_best_furniture/providers/screen_size.dart';
import 'package:the_best_furniture/widgets/custom_textstyle.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: ScreenSize.screenWidth / 30,
            right: ScreenSize.screenWidth / 30),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  'PRODUCTS',
                  style: MyTextStyle.titleStyle,
                )),
            Expanded(
              flex: 5,
              child: Row(
                children: [
                 Expanded(flex: 1, child: FilterSection()),
                  Expanded(flex: 3, child: ProductGridSection()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterSection extends StatelessWidget {
  const FilterSection({super.key});
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
     
      children: [
        CategoryList(),
        SizedBox(
          height: ScreenSize.screenHeight/20,
        ),
        ColorList()
      ],
    );
  }
}

class ProductGridSection extends StatefulWidget {
  const ProductGridSection({Key? key});
  @override
  State<ProductGridSection> createState() => _ProductGridSectionState();
}

class _ProductGridSectionState extends State<ProductGridSection> {
  static String selectedCategory = 'All';
 static String searchQuery = '';
 static String selectedColor = 'All';
 static double selectedPrice = 0.0;
  final ProductService productService = ProductService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: productService.filterProducts(
        selectedCategory:selectedCategory,
        searchQuery: searchQuery,
        selectedColor: selectedColor,
        selectedPrice: selectedPrice,
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
    return Card(
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
                  )),
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
          ]),
    );
  }
}

class CategoryList extends StatelessWidget {
   CategoryList({Key? key});

  final ProductService productService = ProductService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Categories>>(
      stream: productService.getCategoryStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Categories> categories = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: MyTextStyle.bodyStyle,
              ),
              ListView.builder(   
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return TextButton(
                    onPressed: (){

                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(category.name,style: MyTextStyle.bodyStyle,)),
                  );
                },
              ),
            ],
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

class ColorList extends StatefulWidget {
   ColorList({Key? key});

  @override
  State<ColorList> createState() => _ColorListState();
}

class _ColorListState extends State<ColorList> {
  final ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProductColors>>(
      stream: productService.getColorStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<ProductColors> colors = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Colors',
                style: MyTextStyle.bodyStyle,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  final color = colors[index];
                  return TextButton(
                      onPressed: (){
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(color.name,style: MyTextStyle.bodyStyle,)),
                    );
                },
              ),
            ],
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
