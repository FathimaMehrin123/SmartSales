class ProductUnitModel {
  final int unitId;
  final String unitName;
  final double price;

  ProductUnitModel({
    required this.unitId,
    required this.unitName,
    required this.price,
  });

  factory ProductUnitModel.fromJson(Map<String, dynamic> json) {
  final unitList = json['units'] as List?;

  return ProductUnitModel(
    unitId: json['unit'] ?? 0,
    unitName: unitList != null && unitList.isNotEmpty
        ? unitList.first['name'] ?? ''
        : '',
    price: double.tryParse(json['price'].toString()) ?? 0,
  );
}
}