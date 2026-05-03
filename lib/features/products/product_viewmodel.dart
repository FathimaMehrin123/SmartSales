import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartsales/features/products/product_model.dart';
import 'package:smartsales/features/products/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository repository;

  ProductViewModel(this.repository);

  bool isLoading = false;
  String? errorMessage;
  List<ProductModel> products = [];

  Future<void> fetchProducts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final storeId = prefs.getInt('store_id') ?? 112;

      products = await repository.getProducts(
        storeId: storeId.toString(),
      );

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}