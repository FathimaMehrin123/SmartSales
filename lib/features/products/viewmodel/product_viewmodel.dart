import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartsales/features/products/model/product_model.dart';
import 'package:smartsales/features/products/repository/product_repository.dart';
import 'package:smartsales/features/products/model/product_type_model.dart';
import 'package:smartsales/features/products/model/product_unit_model.dart';

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
  List<ProductTypeModel> productTypes = [];
  Future<void> fetchProductTypes() async {
  try {
    productTypes = await repository.getProductTypes();
    notifyListeners();
  } catch (e) {
    errorMessage = e.toString();
    notifyListeners();
  }
}
List<ProductUnitModel> productUnits = [];
bool isDetailLoading = false;
Future<void> fetchProductDetail(int productId) async {
  isDetailLoading = true;
  productUnits = [];
  notifyListeners();

  try {
    productUnits = await repository.getProductDetail(productId: productId);
  } catch (e) {
    errorMessage = e.toString();
  }

  isDetailLoading = false;
  notifyListeners();
}
}