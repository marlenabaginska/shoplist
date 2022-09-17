class ProductModel {
  final String id;
  final String productGroup;
  final String productName;
  final int productQuantity;
  final bool isChecked;

  ProductModel({
    required this.id,
    required this.productGroup,
    required this.productName,
    required this.productQuantity,
    required this.isChecked,
  });
}
