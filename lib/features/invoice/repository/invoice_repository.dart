import 'package:smartsales/core/network/api_client.dart';
import 'package:smartsales/features/invoice/model/invoice_model.dart';

class InvoiceRepository {
  final ApiClient apiClient;

  InvoiceRepository(this.apiClient);

  Future<void> createInvoice(Map<String, dynamic> data) async {
    final response = await apiClient.post(
      "/vansale.store",
      data: data,
    );

    print("Invoice Response: ${response.data}");
  }
  Future<List<InvoiceModel>> getInvoices({
  required String userId,
  required String storeId,
}) async {
  final response = await apiClient.get(
    "/vansale.index",
    params: {
      "user_id": userId,
      "store_id": storeId,
      "van_id": "0",
    },
  );

  print("Invoice List Response: ${response.data}");

final List data = response.data['data']['data'];
  return data.map((e) => InvoiceModel.fromJson(e)).toList();
}
}