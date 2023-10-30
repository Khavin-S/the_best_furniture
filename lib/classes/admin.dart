import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class Admin {
  CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('categories');
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');

  void addCategories(String name, String description) {
    categoryCollection
        .doc(name)
        .set({'name': name, 'description': description});
  }

  Future<void> addProducts(
      String name, int price, String category, String image, int stock) async {
    int allProductCount = await getTotalProductCount();
    int categoryProductCount = await getCategoryProductCount(category);
    productCollection
        .doc("#${category.substring(0, 2).toUpperCase()}-$categoryProductCount")
        .set({
      'id': '#${category.substring(0, 2).toUpperCase()}-$categoryProductCount',
      'name': name,
      'price': price,
      'category': category,
      'image': image,
      'stock': stock,
    });
    await FirebaseFirestore.instance
        .collection("categories")
        .doc(category)
        .set({
      'count': categoryProductCount,
    });
    await FirebaseFirestore.instance
        .collection("categories")
        .doc('All Products')
        .set({
      'count': allProductCount,
    });
  }

  Future<void> deleteProduct(String id) async {
    await productCollection.doc(id).delete();
  }

  Future<int> getTotalProductCount() async {
    var totalcountsnapshot = await categoryCollection.doc('All Products').get();
    return await totalcountsnapshot.get("count");
  }

  Future<int> getCategoryProductCount(String category) async {
    final DocumentSnapshot snapshot =
        await categoryCollection.doc(category).get();
    return await snapshot.get("count");
  }

  Future<String> uploadImageAndGetDownloadUrl(File imageFile) async {
    String fileName = basename(imageFile.path);
    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.whenComplete(() => null);
    String downloadURL = await storageReference.getDownloadURL();
    return downloadURL;
  }
}
