import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoplist/app/models/product_model.dart';
import 'package:shoplist/app/models/purchased_product_model.dart';

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
          productQuantity: (products['product_value']),
          id: products.id,
        );
      }).toList();
    });
  }

  Stream<List<PurchasedProductModel>> getPurchasedProductsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('purchased_products')
        .snapshots()
        .map((querySnapshots) {
      return querySnapshots.docs.map((purchasedProducts) {
        return PurchasedProductModel(
            productGroup: purchasedProducts['product_group'],
            productName: purchasedProducts['product_name'],
            productQuantity: (purchasedProducts['product_quantity']),
            id: purchasedProducts.id);
      }).toList();
    });
  }

  Future<void> add(
    String productGroup,
    String productName,
    int productQuantity,
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
      'product_value': productQuantity,
    });
  }

  Future<void> addYourProduct(
    String productGroup,
    String productName,
    int productQuantity,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('purchased_products')
        .add({
      'product_group': productGroup,
      'product_name': productName,
      'product_quantity': productQuantity,
    });
  }

  Future<void> delete({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('products')
        .doc(id)
        .delete();
  }
}
