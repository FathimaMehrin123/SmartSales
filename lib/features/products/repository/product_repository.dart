import 'package:smartsales/core/network/api_client.dart';
import 'package:smartsales/core/network/api_endpoints.dart';
import 'package:smartsales/features/products/model/product_model.dart';
import 'package:smartsales/features/products/model/product_type_model.dart';
import 'package:smartsales/features/products/model/product_unit_model.dart';

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
  Future<List<ProductTypeModel>> getProductTypes() async {
  final response = await apiClient.get(ApiEndpoints.getProductType);

  print("Product Type Response: ${response.data}");

  final List data = response.data['data'];

  return data.map((e) => ProductTypeModel.fromJson(e)).toList();
}
Future<List<ProductUnitModel>> getProductDetail({
  required int productId,
}) async {
  final response = await apiClient.get(
    ApiEndpoints.getProductDetail,
    params: {
      "product_id": productId,
    },
  );

  print("Product Detail Response: ${response.data}");

  final List units = response.data['data'];

  return units.map((e) => ProductUnitModel.fromJson(e)).toList();
}
}