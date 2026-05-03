class LoginResponseModel {
  final String status;
  final int userId;
  final int storeId;
  final String token;

  LoginResponseModel({
    required this.status,
    required this.userId,
    required this.storeId,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'] ?? '',
      userId: json['user']?['id'] ?? 0,
      storeId: json['user']?['store_id'] ?? 0,
      token: json['authorisation']?['token'] ?? '',
    );
  }

  bool get isSuccess => status == 'success';
}