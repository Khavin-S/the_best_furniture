import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:the_best_furniture/models/collections%20and%20documents.dart';
import 'package:the_best_furniture/models/counts.dart';

class Admin {
 final String name = 'Khavin';
 final String password = '3-Feb-04';
 final String email = 'khavinprince@gmail.com';
 final String phoneNumber = '+91 7538803228';
 final String address = '16, Gandhiji street, Sivagiri, Erode';

  bool login(String adminPassword){
    if(adminPassword == password){
      return true;
    }
    else{
      return false;
    }
  }

  Future<void> addCategory(
      String categoryName,
      String categorySlogan) async {
    try {
      Collections.categoriesCollection.doc(categoryName).set({
        'name': categoryName,
        'count': 0,
        'count_id': 0,
        'slogan': categorySlogan,
      });
    } catch (e) {
      print('Error adding category: $e');
    }
  }

  void addColors(String colorName) {
    try {
      Collections.colorsCollectionCollection
          .doc(colorName)
          .set({'name': colorName, 'count': 0});
    } catch (e) {
      print('Error adding colors: $e');
    }
  }

  Future<void> addProducts(String productName, String productDescription, int productPrice,
    String productCategory, String productImage, int productStock, String productColor) async {
    try{
     DocumentSnapshot snapshot =  await Collections.categoriesCollection.doc(productCategory).get();
      int categoryCount = snapshot['count'] + 1;
      int categoryIdCount = snapshot['count_id'] + 1;
    /*int categoryCount =
        await (GetCounts.getCategoryProductCount(productCategory)) + 1;
    int categoryCountId =
        await (GetCounts.getCategoryProductCountId(productCategory)) + 1;*/
    //DateTime serverTime = DateTime.now();
    await Collections.productsCollection
        .doc("#${productCategory.substring(0, 2).toUpperCase()}-$categoryIdCount")
        .set({
      'id': '#${productCategory.substring(0, 2).toUpperCase()}-$categoryIdCount',
      'name': productName,
      'price': productPrice,
      'category': productCategory,
      'image': productImage,
      'stock': productStock,
      'color': productColor,
      'description': productDescription,
      'createdTime': FieldValue.serverTimestamp(),
    });
    await Collections.categoriesCollection.doc(productCategory).update(
      {
        'count': categoryCount,
        'count_id' : categoryIdCount
      }
    );
    /*SetCount.updateCategoryCount(productCategory, categoryCount);
    SetCount.updateCategoryCountId(productCategory, categoryIdCount);*/
    int productCount = await (GetCounts.getTotalProductCount()) + 1;
    await SetCount.updateProductCount(productCount);
    }
    catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> deleteProduct(String id, String category) async {
    await Collections.productsCollection.doc(id).delete();
    int productCount = await (GetCounts.getTotalProductCount()) - 1;
    await SetCount.updateProductCount(productCount);
    int categoryCount = await (GetCounts.getCategoryProductCount(category)) - 1;
    SetCount.updateCategoryCount(category, categoryCount);
  }

  Future<void> updateProduct(String productId, String name, int price,
      String category, String image, int stock, String color) async {
    await Collections.productsCollection.doc(productId).set({
      'name': name,
      'price': price,
      'category': category,
      'image': image,
      'stock': stock,
      'color': color,
    });
  }

  Future<int> productCount() async {
    return await (GetCounts.getTotalProductCount());
  }

  Future<int> userCount() async {
    return await (GetCounts.getTotalProductCount());
  }

  Future<int> liveorderCount() async {
    return await (GetCounts.getLiveOrdersCount());
  }

  Future<int> orderCount() async {
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
