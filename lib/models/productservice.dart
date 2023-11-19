import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_best_furniture/models/cart.dart';
import 'package:the_best_furniture/models/collections%20and%20documents.dart';
import 'package:the_best_furniture/models/colors.dart';
import 'package:the_best_furniture/models/product.dart';
import 'package:the_best_furniture/models/category.dart';

class ProductService {
  Stream<List<Product>> getProductStream(
      {required int minPrice,
      required int maxPrice,
      required String category,
      required String color,
      required String searchQuery,
      required bool sortByNewest}) {
    CollectionReference products = Collections.productsCollection;
    Query productsQuery = products;
    if(category == 'all' && searchQuery =='all' && minPrice==0 && maxPrice==100000 && color=='all' && !sortByNewest){
        return productsQuery.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((doc) =>
        Product.fromMap(doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList());
    }
    else{
    if(sortByNewest){
      productsQuery = products.orderBy('createdTime' , descending: true);
    }
    if (minPrice != 0) {
      productsQuery = products.where('price', isGreaterThanOrEqualTo: minPrice);
    }
    if (maxPrice != 10000) {
      productsQuery = products.where('price', isLessThanOrEqualTo: maxPrice);
    }
    if (category != 'all') {
      productsQuery = products.where('category', isEqualTo: category);
    }
    if (color != 'all') {
      productsQuery = products.where('color', isEqualTo: color);
    }
    if (searchQuery != "") {
      String lowercasedQuery = searchQuery.toLowerCase();
      productsQuery = products.where('name', isEqualTo: lowercasedQuery);
    }
    return productsQuery.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((doc) =>
            Product.fromMap(doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList());
    }
  }

  Stream<List<Categories>> getCategoryStream() {
    return Collections.categoriesCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((doc) => Categories.fromMap(
                doc as DocumentSnapshot<Map<String, dynamic>>))
            .toList());
  }

  Stream<List<ProductColors>> getColorStream() {
    return Collections.colorsCollectionCollection.snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((doc) => ProductColors.fromMap(
                doc as DocumentSnapshot<Map<String, dynamic>>))
            .toList());
  }

  // Get Products according to the Cart's productId
  Future<List<Product>> getProductsFromCart(List<Cart> cartItems) async {
    List<Product> products = [];

    for (var cartItem in cartItems) {
      final productSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(cartItem.productId)
          .get();

      if (productSnapshot.exists) {
        products.add(Product.fromMap(productSnapshot));
      }
    }

    return products;
  }
}
