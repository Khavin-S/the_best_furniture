import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_best_furniture/classes/product.dart';

class ProductService {
  final CollectionReference bannersCollection =
      FirebaseFirestore.instance.collection('banners');
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  Stream<List<Product>> getProductStream() {
    return productsCollection.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((doc) =>
            Product.fromMap(doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList());
  }
}
