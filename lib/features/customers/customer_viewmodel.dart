import 'package:flutter/material.dart';
import 'package:smartsales/features/customers/customer_model.dart';
import 'package:smartsales/features/customers/customer_repository.dart';


class CustomerViewModel extends ChangeNotifier {
  final CustomerRepository repository;

  CustomerViewModel(this.repository);

  bool isLoading = false;
  String? errorMessage;
  List<CustomerModel> customers = [];

  Future<void> fetchCustomers() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await repository.getCustomers(
        routeId: "84",
        storeId: "112",
      );

      customers = result;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}