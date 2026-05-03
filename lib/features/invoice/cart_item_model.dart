class CartItemModel {
  final int productId;
  final String productName;
  final double rate;
  int quantity;

  CartItemModel({
    required this.productId,
    required this.productName,
    required this.rate,
    this.quantity = 1,
  });

  double get amount => rate * quantity;
}