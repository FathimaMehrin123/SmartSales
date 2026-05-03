class CustomerModel {
  final int id;
  final String name;
  final String address;
  final String phone;

  CustomerModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      phone: json['contact_number'] ?? '',
    );
  }
}