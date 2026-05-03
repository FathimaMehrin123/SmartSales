import 'package:dio/dio.dart';
import 'api_endpoints.dart';

class ApiClient {
  late Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
  }

  /// GET Request
  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: params,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// POST Request
  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Error Handling
  String _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return "Connection timeout";
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return "Receive timeout";
    } else if (e.type == DioExceptionType.badResponse) {
      return "Server error: ${e.response?.statusCode}";
    } else if (e.type == DioExceptionType.connectionError) {
      return "No internet connection";
    } else {
      return "Something went wrong";
    }
  }
}