import 'package:flutter/material.dart';
import 'package:the_best_furniture/classes/collections%20and%20documents.dart';
import 'package:the_best_furniture/classes/counts.dart';
import 'package:the_best_furniture/classes/product.dart';
import 'package:the_best_furniture/classes/productservice.dart';
import 'package:the_best_furniture/others/widegts.dart';
import 'package:the_best_furniture/pages/user/productpage.dart';

class Admin {
  void addCategories(String name, String description) {
    Collections.categoriesCollection
        .doc(name)
        .set({'name': name, 'description': description, 'count': 0});
  }

  Future<void> addProducts(String name, int price, String? category, String? image, int stock) async {
    int categoryCount = await (GetCounts.getCategoryProductCount(category!))+1;
    Collections.productsCollection
        .doc("#${category.substring(0, 2).toUpperCase()}-$categoryCount")
        .set({
      'id': '#${category.substring(0, 2).toUpperCase()}-$categoryCount',
      'name': name,
      'price': price,
      'category': category,
      'image': image,
      'stock': stock,
    });
    SetCount.updateCategoryCount(category, categoryCount);
    int productCount = await (GetCounts.getTotalProductCount())+1;
    await SetCount.updateProductCount(productCount);
  }

  Future<void> deleteProduct(String id,String category) async {
    await Collections.productsCollection.doc(id).delete();
    int productCount = await (GetCounts.getTotalProductCount())-1;
    await SetCount.updateProductCount(productCount);
    int categoryCount = await (GetCounts.getCategoryProductCount(category))-1;
    SetCount.updateCategoryCount(category, categoryCount);
  }

  Future<void> updateProduct(String productId, String name, int price,
      String category, String image, int stock) async {
    await Collections.productsCollection.doc(productId).set({
      'name': name,
      'price': price,
      'category': category,
      'image': image,
      'stock': stock,
    });
  }

  Future<int> productCount() async{
   return await (GetCounts.getTotalProductCount());
  }
  Future<int> userCount() async{
   return await (GetCounts.getTotalProductCount());
  }
  Future<int> liveorderCount() async{
   return await (GetCounts.getLiveOrdersCount());
  }
  Future<int> orderCount() async{
   return await (GetCounts.getordersCount());
  }
  
 
}
