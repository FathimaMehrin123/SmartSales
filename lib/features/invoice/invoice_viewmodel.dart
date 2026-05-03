import 'package:flutter/material.dart';
import 'cart_item_model.dart';

class InvoiceViewModel extends ChangeNotifier {
  final List<CartItemModel> _cartItems = [];

  List<CartItemModel> get cartItems => _cartItems;

  double total = 0;
  double tax = 0;
  double roundOff = 0;
  double grandTotal = 0;

  bool isVatEnabled = true;

  void addProduct(CartItemModel item) {
    final index = _cartItems.indexWhere(
      (element) => element.productId == item.productId,
    );

    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(item);
    }

    calculateTotal();
    notifyListeners();
  }

  void increaseQuantity(int productId) {
    final index = _cartItems.indexWhere((item) => item.productId == productId);

    if (index != -1) {
      _cartItems[index].quantity++;
      calculateTotal();
      notifyListeners();
    }
  }

  void decreaseQuantity(int productId) {
    final index = _cartItems.indexWhere((item) => item.productId == productId);

    if (index != -1 && _cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
      calculateTotal();
      notifyListeners();
    }
  }

  void removeProduct(int productId) {
    _cartItems.removeWhere((item) => item.productId == productId);
    calculateTotal();
    notifyListeners();
  }

  void changeVatStatus(bool value) {
    isVatEnabled = value;
    calculateTotal();
    notifyListeners();
  }

  void calculateTotal() {
    total = _cartItems.fold(0, (sum, item) => sum + item.amount);

    tax = isVatEnabled ? total * 0.05 : 0;

    final beforeRound = total + tax;
    grandTotal = beforeRound.roundToDouble();

    roundOff = grandTotal - beforeRound;
  }

  void clearCart() {
    _cartItems.clear();
    total = 0;
    tax = 0;
    roundOff = 0;
    grandTotal = 0;
    notifyListeners();
  }
}