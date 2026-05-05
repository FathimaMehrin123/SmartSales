class CartItemModel {
  final int productId;
  final String productName;
  final double rate;
  int quantity;
final String productTypeName;
final String unitName;
  CartItemModel({
    required this.productId,
    required this.productName,
    required this.rate,
    this.quantity = 1,
     required this.productTypeName,
  required this.unitName,
  });

  double get amount => rate * quantity;
}