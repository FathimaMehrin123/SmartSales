import 'package:smartsales/features/customers/customer_model.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';

class CustomerRepository {
  final ApiClient apiClient;

  CustomerRepository(this.apiClient);

  Future<List<CustomerModel>> getCustomers({
    required String routeId,
    required String storeId,
  }) async {
    final response = await apiClient.get(
      ApiEndpoints.getCustomer,
      params: {"route_id": routeId, "store_id": storeId},
    );
    print("Customer API Response: ${response.data}");
    final List data = response.data['data'];

    return data.map((e) => CustomerModel.fromJson(e)).toList();
  }
}
