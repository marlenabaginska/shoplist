part of 'your_products_cubit.dart';

@immutable
class YourProductsState {
  final List<PurchasedProductModel> purchasedProducts;
  const YourProductsState({this.purchasedProducts = const []});
}
