import 'package:smartsales/core/network/api_client.dart';
import 'package:smartsales/core/network/api_endpoints.dart';
import 'package:smartsales/features/auth/models/user_model.dart';
import 'package:smartsales/features/auth/viewmodel/login_response_model.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);

  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.post(
      ApiEndpoints.login,
      data: {"email": email, "password": password},
    );
    print(response.data);
    return LoginResponseModel.fromJson(response.data);
  }

  Future<UserModel> getUserDetail(int userId) async {
  final response = await apiClient.get(
    ApiEndpoints.getUserDetail,
    params: {
      "user_id": userId,
    },
  );

  final data = response.data['data'];

  return UserModel.fromJson(data);
}
}
