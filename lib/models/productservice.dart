import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_best_furniture/models/collections%20and%20documents.dart';
import 'package:the_best_furniture/models/product.dart';
import 'package:the_best_furniture/models/category.dart';

class ProductService { 
  Stream<List<Product>> getProductStream() {
    return Collections.productsCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((doc) =>
                Product.fromMap(doc as DocumentSnapshot<Map<String, dynamic>>))
            .toList());         
  }

  Stream<List<Categories>> getCategoryStream() {
    return Collections.categoriesCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((doc) => Categories.fromMap(
                doc as DocumentSnapshot<Map<String, dynamic>>))
            .toList());
  }

  Stream<List<Product>> filterProducts({
    required String selectedCategory,
    required String searchQuery,
    required String selectedColor,
    required double selectedPrice,
  }) {
    return getProductStream().map((allProducts) {
      return allProducts
          .where((product) =>
              (selectedCategory == 'All' || product.category == selectedCategory) &&
              (product.name.toLowerCase().contains(searchQuery.toLowerCase())) &&
              (selectedColor == 'All' || product.color == selectedColor) &&
              (selectedPrice == 0.0 || product.price <= selectedPrice))
          .toList();
    });
  }
}

