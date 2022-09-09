import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:shoplist/app/models/product_model.dart';
import 'package:shoplist/app/repositories/products_repositories.dart';

part 'shop_list_state.dart';

class ShopListCubit extends Cubit<ShopListState> {
  ShopListCubit(this._productsRepository)
      : super(
          const ShopListState(),
        );

  final ProductsRepository _productsRepository;

  Future<void> add(
    String productGroup,
    String productName,
    String productQuantity,
  ) async {
    try {
      await _productsRepository.add(
        productGroup,
        productName,
        productQuantity,
      );
      emit(const ShopListState());
    } catch (error) {}
  }
}

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productsRepository)
      : super(const ProductState(products: []));

  StreamSubscription? _streamSubscription;

  final ProductsRepository _productsRepository;

  Future<void> start() async {
    _streamSubscription =
        _productsRepository.getProductsStream().listen((products) {
      emit(ProductState(products: products));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
