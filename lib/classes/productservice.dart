import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:the_best_furniture/classes/product.dart';
import 'package:the_best_furniture/classes/category.dart';

class ProductService {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('categories');

  Stream<List<Product>> getProductStream() {
    return productsCollection.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((doc) =>
            Product.fromMap(doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList());
  }

  Stream<List<Category>> getCategoryStream() {
    return categoryCollection.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((doc) =>
            Category.fromMap(doc as DocumentSnapshot<Map<String, dynamic>>))
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
