import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_best_furniture/models/collections%20and%20documents.dart';

class GetCounts {
  static Future<int> getTotalProductCount() async {
    final DocumentSnapshot snapshot = await Documents.productsCount.get();
    return await snapshot.get('count');
  }

  static Future<int> getCategoryProductCount(String category) async {
    final DocumentSnapshot snapshot =
        await Collections.categoriesCollection.doc(category).get();
    return await snapshot.get('count');
  }
  static Future<int> getCategoryProductCountId(String category) async {
    final DocumentSnapshot snapshot =
        await Collections.categoriesCollection.doc(category).get();
    return await snapshot.get('count_id');
  }

  static Future<int> getTotalUserCount() async {
    final DocumentSnapshot snapshot = await Documents.usersCount.get();
    return await snapshot.get('count');
  }
  static Future<int> getTotalUserIdCount() async {
    final DocumentSnapshot snapshot = await Documents.usersCount.get();
    return await snapshot.get('count_id');
  }

  static Future<int> getLiveOrdersCount() async {
    final DocumentSnapshot snapshot = await Documents.liveordersCount.get();
    return await snapshot.get('count');
  }

  static Future<int> getordersCount() async {
    final DocumentSnapshot snapshot = await Documents.ordersCount.get();
    return await snapshot.get('count');
  }
}

class SetCount {
  static Future<void> updateUserCount(int count) async {
    await Documents.usersCount.update({'count': count});
  }
  static Future<void> updateUserIdCount(int count) async {
    await Documents.usersCount.update({'count': count});
  }

  static Future<void> updateProductCount(int count) async {
    await Documents.productsCount.update({'count': count});
  }

  static Future<void> updateCategoryCount(String category, int count) async {
    await Collections.categoriesCollection
        .doc(category).update({'count': count});
  }
  static Future<void> updateCategoryCountId(String category, int count) async {
    await Collections.categoriesCollection
        .doc(category).update({'count_id': count});
  }
}
