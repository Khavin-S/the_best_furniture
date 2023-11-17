import 'package:flutter/material.dart';
import 'package:the_best_furniture/models/admin.dart';
import 'package:the_best_furniture/models/product.dart';
import 'package:the_best_furniture/models/productservice.dart';
import 'package:the_best_furniture/pages/admin/addproduct_page.dart';
import 'package:the_best_furniture/pages/admin/updateproduct_page.dart';
import 'package:the_best_furniture/providers/navigation.dart';
import 'package:the_best_furniture/providers/screen_size.dart';
import 'package:the_best_furniture/widgets/custom_adminappbar.dart';
import 'package:the_best_furniture/widgets/custom_textstyle.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String currentContent = 'Products';
  String currentContentText = 'Products Overview';

  void changePage(String page) {
    setState(() {
      currentContent = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  MyAdminAppBar(),
                ],
            body: Padding(
              padding: EdgeInsets.all(ScreenSize.screenWidth / 50),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    alignment: Alignment.topLeft,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.black, width: 2))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(currentContentText,
                            style: MyTextStyle.subtitleStyle),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_horiz_sharp),
                          onSelected: (String value) {},
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<String>>[
                              PopupMenuItem(
                                onTap: () {
                                  changePage('Products');
                                },
                                value: 'Option 1',
                                child: const Text(
                                  "Manage Products",
                                  style: TextStyle(color: Colors.deepPurple),
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  changePage('Orders');
                                },
                                value: 'Option 2',
                                child: const Text(
                                  "Manage Orders",
                                  style: TextStyle(color: Colors.deepPurple),
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  changePage('Users');
                                },
                                value: 'Option 3',
                                child: const Text(
                                  "Manage users",
                                  style: TextStyle(color: Colors.deepPurple),
                                ),
                              ),
                            ];
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: getListContent(),
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget getListContent() {
    switch (currentContent) {
      case "Users":
        return userList();

      case "Products":
        currentContentText = "Product Overview";
        return productList();

      default:
        return Text('none');
    }
  }

  Widget productList() {
    final ProductService productService = ProductService();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
            height: 80,
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
            Navigation.goto(context, ProductManagement());
          },
        ),
        Expanded(
          child: StreamBuilder<List<Product>>(
            stream: productService.getProductStream(),
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
                              child: Text(product.price.toStringAsFixed(2),
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
                                  Navigation.goto(context, UpdateProductPage(name: product.name, color: product.color, image: product.image, category: product.category, description: product.description, price: product.price, stock: product.stock));
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
            },
          ),
        ),
      ],
    );
  }

  Widget userList() {
    final ProductService productService = ProductService();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<List<Product>>(
          stream: productService.getProductStream(),
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
                        border: Border(bottom: BorderSide(color: Colors.grey))),
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
                            child: Text(product.price.toStringAsFixed(2),
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
                               // Navigation.goto(context, ());
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
          },
        ),
      ],
    );
  }
}
