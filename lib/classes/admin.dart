import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class Admin {
  void addCategories(String name, String description) {
    FirebaseFirestore.instance
        .collection('categories')
        .doc(name)
        .set({'name': name, 'description': description});
  }

  Future<void> addProducts(String id, String name, int price, String category,
      String image, String stock) async {
    FirebaseFirestore.instance.collection('products').doc("Product-$id").set({
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'image': image,
      'stock': stock,
    });
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
