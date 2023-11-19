import 'package:flutter/material.dart';
import 'package:the_best_furniture/pages/screen/dashboard_page.dart';
import 'package:the_best_furniture/pages/screen/product_managament_page.dart';
import 'package:the_best_furniture/pages/screen/user_management_page.dart';
import 'package:the_best_furniture/providers/navigation.dart';

class OrderManagementPage extends StatelessWidget {
  OrderManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 1, child: DashboardNavigationSection()),
          const Expanded(flex: 4, child: OrderManagementSection())
        ],
      ),
    );
  }
}

class DashboardNavigationSection extends StatelessWidget {
  DashboardNavigationSection({super.key});
  List<String> items = ["Reports", "Orders", "Products", "Users"];
  int selectedItemIndex = 1;
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
              Navigation.goto(context, const DashboardPage());
            }
            if (index == 2) {
              Navigation.goto(context, ProductManagementPage());
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

class OrderManagementSection extends StatelessWidget {
  const OrderManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
