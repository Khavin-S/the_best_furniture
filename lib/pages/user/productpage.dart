import 'package:flutter/material.dart';
import 'package:the_best_furniture/classes/product.dart';
import 'package:the_best_furniture/classes/user.dart';
import 'package:the_best_furniture/others/widegts.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              MyAppBar(title: "THE BEST FURNITURE"),
            ],
            body: Row(
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
    return User().viewProduct();
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;

  const ProductCard({required this.product,required this.index});
  @override
  Widget build(BuildContext context) {
    Color color;
    if(index%2==0){
      color=Colors.red;
    }
    else{
      color=Colors.black;
    }
    return Card(
      elevation: 4,
      shadowColor: Colors.blue,
      color: color,
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
