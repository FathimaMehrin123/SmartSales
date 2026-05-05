class CartItemModel {
  final int productId;
  final String productName;
  final double rate;
  int quantity;

  final int productTypeId;
  final String productTypeName;

  final int unitId;
  final String unitName;

  CartItemModel({
    required this.productId,
    required this.productName,
    required this.rate,
    required this.quantity,
    required this.productTypeId,
    required this.productTypeName,
    required this.unitId,
    required this.unitName,
  });

  double get amount => rate * quantity;
}