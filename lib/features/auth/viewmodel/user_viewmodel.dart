import 'package:flutter/material.dart';
import 'package:smartsales/features/auth/models/user_model.dart';
import 'package:smartsales/features/auth/repository/auth_repository.dart';


class UserViewModel extends ChangeNotifier {
  final AuthRepository repository;

  UserViewModel(this.repository);

  UserModel? user;
  bool isLoading = false;
  String? error;

  Future<void> fetchUser(int userId) async {
    isLoading = true;
    notifyListeners();

    try {
      user = await repository.getUserDetail(userId);
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}