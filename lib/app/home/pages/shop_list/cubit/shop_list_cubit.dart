import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'shop_list_state.dart';

class ShopListCubit extends Cubit<ShopListState> {
  ShopListCubit()
      : super(
          const ShopListState(),
        );

  Future<void> add({
    required String productGroup,
    required String productName,
    required String productQuantity,
  }) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc('7bIAQqYKtnVz7987oq3WtQyW7Qz1')
        .collection('products')
        .add({
      'product_group': productGroup,
      'product_name': productName,
      'product_quantity': productQuantity,
    });
  }
}

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState(products: []));

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc('7bIAQqYKtnVz7987oq3WtQyW7Qz1')
        .collection('products')
        .snapshots()
        .listen((product) {
      emit(ProductState(
        products: product.docs,
      ));
    })
      ..onError((error) {
        emit(
          const ProductState(
            products: [],
          ),
        );
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
