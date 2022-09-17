import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoplist/app/models/purchased_product_model.dart';
import 'package:shoplist/app/repositories/products_repositories.dart';

part 'your_products_state.dart';

class YourProductsCubit extends Cubit<YourProductsState> {
  YourProductsCubit(this._productsRepository)
      : super(
          const YourProductsState(),
        );
  StreamSubscription? _streamSubscription;

  final ProductsRepository _productsRepository;
  Future<void> start() async {
    _streamSubscription = _productsRepository
        .getPurchasedProductsStream()
        .listen((purchasedProduct) {
      emit(YourProductsState(purchasedProducts: purchasedProduct));
    });
  }

  Future<void> addYourProduct(
    String purchasedProductGroup,
    String purchasedProductName,
    int purchasedProductQuantity,
    String storageName,
  ) async {
    try {
      await _productsRepository.addYourProduct(
        purchasedProductGroup,
        purchasedProductName,
        purchasedProductQuantity,
        storageName,
      );
      emit(const YourProductsState());
    } catch (error) {}
  }

  Future<void> delete({required String documentID}) {
    return _productsRepository.delete(id: documentID);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
