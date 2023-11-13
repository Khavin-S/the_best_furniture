import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:the_best_furniture/models/collections%20and%20documents.dart';
import 'package:the_best_furniture/models/counts.dart';


class Admin {
  void addCategories(String name, String description, String image) {
    Collections.categoriesCollection
        .doc(name)
        .set({'name': name, 'description': description, 'count': 0, 'image': image});
  }

  Future<void> addProducts(String name, int price, String? category, String? image, int stock, String color) async {
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
      'color': color,
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
      String category, String image, int stock,String color) async {
    await Collections.productsCollection.doc(productId).set({
      'name': name,
      'price': price,
      'category': category,
      'image': image,
      'stock': stock,
      'color': color,
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


    Future<File?> pickImageForProduct() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      print("No file selected");
    }
    return null;
  }
}
