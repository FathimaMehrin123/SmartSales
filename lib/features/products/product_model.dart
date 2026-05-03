class ProductModel {
  final int id;
  final String name;
  final String code;
  final double price;

  ProductModel({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0,
    );
  }
}