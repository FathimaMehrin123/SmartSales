import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'invoice_model.dart';
import 'invoice_repository.dart';

class InvoiceListViewModel extends ChangeNotifier {
  final InvoiceRepository repository;

  InvoiceListViewModel(this.repository);

  bool isLoading = false;
  String? error;
  List<InvoiceModel> invoices = [];

  Future<void> fetchInvoices() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();

      final userId = prefs.getInt('user_id') ?? 0;
      final storeId = prefs.getInt('store_id') ?? 0;

      invoices = await repository.getInvoices(
        userId: userId.toString(),
        storeId: storeId.toString(),
      );

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }
}