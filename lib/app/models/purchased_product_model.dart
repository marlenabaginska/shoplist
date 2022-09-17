class PurchasedProductModel {
  final String id;
  final String purchasedProductGroup;
  final String purchasedProductName;
  final int purchasedProductQuantity;
  final String storageName;

  PurchasedProductModel({
    required this.id,
    required this.purchasedProductGroup,
    required this.purchasedProductName,
    required this.purchasedProductQuantity,
    required this.storageName,
  });
}
