import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_best_furniture/models/collections%20and%20documents.dart';
import 'package:the_best_furniture/models/colors.dart';
import 'package:the_best_furniture/models/product.dart';
import 'package:the_best_furniture/models/category.dart';     

class ProductService { 
  Stream<List<Product>> getProductStream( {int? minPrice, int? maxPrice, String? category, String? color,String? searchQuery,bool? sortByNewest}) {
    CollectionReference  products  = Collections.productsCollection;
    Query productsQuery = products.orderBy('createdTime', descending: true);
    if (minPrice != null) {
      productsQuery  = products .where('price', isGreaterThanOrEqualTo: minPrice);
    }
    if (maxPrice != null) {
      productsQuery = products.where('price', isLessThanOrEqualTo: maxPrice);
    }
    if (category != null) {
      productsQuery = products.where('category', isEqualTo: category);
    }
    if (color != null) {
      productsQuery = products.where('color', isEqualTo: color);
    }
    if (searchQuery != null && searchQuery !="") {
    String lowercasedQuery = searchQuery.toLowerCase();
    productsQuery = products.where('name', isEqualTo: lowercasedQuery);
  }
    return productsQuery.snapshots().map((querySnapshot) =>
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

  Stream<List<ProductColors>> getColorStream() {
    return Collections.colorsCollectionCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((doc) => ProductColors.fromMap(
                doc as DocumentSnapshot<Map<String, dynamic>>))
            .toList());
  }

}