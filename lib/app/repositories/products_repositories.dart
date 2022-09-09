import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoplist/app/models/product_model.dart';

class ProductsRepository {
  Stream<List<ProductModel>> getProductsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('products')
        .snapshots()
        .map((querySnapshots) {
      return querySnapshots.docs.map((products) {
        return ProductModel(
          productGroup: products['product_group'],
          productName: products['product_name'],
          productQuantity: products['product_quantity'],
          id: products.id,
        );
      }).toList();
    });
  }

  Future<void> add(
    String productGroup,
    String productName,
    String productQuantity,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('products')
        .add({
      'product_group': productGroup,
      'product_name': productName,
      'product_quantity': productQuantity,
    });
  }
}
