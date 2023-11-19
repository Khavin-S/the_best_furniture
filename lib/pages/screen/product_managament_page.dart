import 'package:flutter/material.dart';
import 'package:the_best_furniture/models/admin.dart';
import 'package:the_best_furniture/models/product.dart';
import 'package:the_best_furniture/models/productservice.dart';
import 'package:the_best_furniture/pages/screen/add_product_page.dart';
import 'package:the_best_furniture/pages/screen/update_product_page.dart';
import 'package:the_best_furniture/pages/screen/dashboard_page.dart';
import 'package:the_best_furniture/pages/screen/order_management_page.dart';
import 'package:the_best_furniture/pages/screen/user_management_page.dart';
import 'package:the_best_furniture/providers/navigation.dart';
import 'package:the_best_furniture/widgets/custom_textstyle.dart';

class ProductManagementPage extends StatelessWidget {
  ProductManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 1, child: DashboardNavigationSection()),
          Expanded(flex: 4, child: ProductManagementSection())
        ],
      ),
    );
  }
}

class DashboardNavigationSection extends StatelessWidget {
  DashboardNavigationSection({super.key});
  List<String> items = ["Reports", "Orders", "Products", "Users"];
  int selectedItemIndex = 2;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(items[index]),
          tileColor: index == selectedItemIndex ? Colors.deepPurple : null,
          onTap: () {
            if (index == 0) {
              Navigation.goto(context, DashboardPage());
            }
            if (index == 1) {
              Navigation.goto(context, OrderManagementPage());
            }
            if (index == 3) {
              Navigation.goto(context, UserManagementPage());
            }
          },
        );
      },
    );
  }
}

class ProductManagementSection extends StatelessWidget {
  ProductManagementSection({super.key});
  final ProductService productService = ProductService();
  int selectedMinPrice = 0;
  int selectedMaxPrice = 100000;
  String selectedColor = 'all';
  String selectedCategory = 'all';
  String searchQuery = 'all';
  bool isSortByNewest = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Expanded(
          flex: 1,
           child: ListTile(
            title: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add products', style: MyTextStyle.bodyStyle),
                  Icon(
                    Icons.add,
                    color: Colors.deepPurple,
                  )
                ],
              ),
            ),
            onTap: () {
              Navigation.goto(context,  AddProductPage());
            },
                 ),
         ),
        Expanded(
          flex: 6,
          child: StreamBuilder<List<Product>>(
              stream: productService.getProductStream(
                  minPrice: selectedMinPrice,
                  maxPrice: selectedMaxPrice,
                  color: selectedColor,
                  category: selectedCategory,
                  searchQuery: searchQuery,
                  sortByNewest: isSortByNewest),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<Product> products = snapshot.data!;
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      var product = products[index];
                      return Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey))),
                        height: 80,
                        child: ListTile(
                          leading: Image.network(
                            product.image,
                            width: 50,
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  product.id,
                                  style: MyTextStyle.bodyStyle,
                                ),
                              ),
                              Expanded(
                                child: Text(product.name,
                                    style: MyTextStyle.bodyStyle),
                              ),
                              Expanded(
                                  child: Text(product.category,
                                      style: MyTextStyle.bodyStyle)),
                              Expanded(
                                child: Text(product.price.toString(),
                                    style: MyTextStyle.bodyStyle),
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton<String>(
                            icon: const Icon(Icons.more_horiz_sharp),
                            onSelected: (String value) {},
                            itemBuilder: (BuildContext context) {
                              return <PopupMenuEntry<String>>[
                                PopupMenuItem(
                                  onTap: () {
                                    Navigation.goto(
                                        context,
                                        UpdateProductPage(
                                          productId: product.id,
                                            productName: product.name,
                                            productColor: product.color,
                                            productImage: product.image,
                                            productCategory: product.category,
                                            productDescription: product.description,
                                            productPrice: product.price,
                                            productStock: product.stock));
                                  },
                                  value: 'Option 1',
                                  child: const Text(
                                    "Update product",
                                    style: TextStyle(color: Colors.deepPurple),
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () {
                                    Admin().deleteProduct(
                                        product.id, product.category);
                                  },
                                  value: 'Option 2',
                                  child: const Text(
                                    "Delete Product",
                                    style: TextStyle(color: Colors.deepPurple),
                                  ),
                                ),
                              ];
                            },
                          ),
                        ),
                      );
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
              }),
        ),
      ],
    );
  }
}
