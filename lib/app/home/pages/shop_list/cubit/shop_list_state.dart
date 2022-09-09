part of 'shop_list_cubit.dart';

@immutable
class ShopListState {
  const ShopListState();
}

@immutable
class ProductState {
  final List<ProductModel> products;

  const ProductState({
    required this.products,
  });
}
