import 'package:flutter/material.dart';
import 'package:the_best_furniture/pages/admin%20dashboard/productmanagement.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String currentPage = 'Dashboard';

  void changePage(String page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Row(
        children: <Widget>[
          Container(
            width: 200,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Dashboard'),
                  selected: currentPage == 'Dashboard',
                  onTap: () {
                    changePage('Dashboard');
                  },
                ),
                ListTile(
                  title: const Text('Products'),
                  selected: currentPage == 'Products',
                  onTap: () {
                    changePage('Products');
                  },
                ),
                ListTile(
                  title: const Text('Users'),
                  selected: currentPage == 'Users',
                  onTap: () {
                    changePage('Users');
                  },
                ),
                // Add more menu items for different sections of the admin dashboard
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: getContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget getContent() {
    switch (currentPage) {
      case 'Dashboard':
        return Center(
          child: Text('Welcome to the Admin Dashboard!'),
        );
      case 'Products':
        return ProductManagement();
      case 'Users':
        // Add the user management content here
        return Center(
          child: Text('User Management Page'),
        );
      // Add cases for other sections of the admin dashboard
      default:
        return Center(
          child: Text('Select a section from the sidebar menu.'),
        );
    }
  }
}