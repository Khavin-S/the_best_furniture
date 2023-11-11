import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:the_best_furniture/classes/collections%20and%20documents.dart';
import 'package:the_best_furniture/classes/product.dart';
import 'package:the_best_furniture/classes/category.dart';

class ProductService {
  Stream<List<Product>> getProductStream() {
    return Collections.productsCollection.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((doc) =>
            Product.fromMap(doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList());
  }

  Stream<List<Categories>> getCategoryStream() {
    return Collections.categoriesCollection.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((doc) =>
            Categories.fromMap(doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList());
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
