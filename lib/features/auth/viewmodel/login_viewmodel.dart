import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartsales/features/auth/repository/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository authRepository;

  LoginViewModel(this.authRepository);

  bool isLoading = false;
  String? errorMessage;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

   try {
  final result = await authRepository.login(
    email: email,
    password: password,
  );

  if (result.isSuccess) {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setInt('user_id', result.userId);
  await prefs.setInt('store_id', result.storeId);
  await prefs.setString('token', result.token);

  isLoading = false;
  notifyListeners();
  return true;
} else {
    isLoading = false;
    errorMessage = "Login failed";
    notifyListeners();
    return false;
  }
} catch (e) {
  isLoading = false;
  errorMessage = e.toString();
  notifyListeners();
  return false;
}
  }
}