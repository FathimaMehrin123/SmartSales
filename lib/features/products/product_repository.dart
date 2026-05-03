import 'package:smartsales/core/network/api_client.dart';
import 'package:smartsales/core/network/api_endpoints.dart';
import 'package:smartsales/features/products/product_model.dart';

class ProductRepository {
  final ApiClient apiClient;

  ProductRepository(this.apiClient);

  Future<List<ProductModel>> getProducts({
    required String storeId,
  }) async {
    final response = await apiClient.get(
      ApiEndpoints.getProduct,
      params: {
        "store_id": storeId,
      },
    );

    print("Product API Response: ${response.data}");

  final List data = response.data['data']['data'];
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }
}