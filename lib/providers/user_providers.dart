import 'package:flutter/material.dart';
import 'package:movie_app/models/user_model.dart';
import 'package:movie_app/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? user;
  String? error;
  bool isLoading = false;

  Future<void> authLogin(UserModel loginModel) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await AuthService().postLogin(loginModel); // result almıyoruz
      // Başarılı olduğunu varsayıyoruz
      user = loginModel; // veya başka bir kontrol
      error = null;
    } catch (e) {
      error = 'Giriş başarısız!';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> authRegister(UserModel registerModel) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await AuthService().postRegister(registerModel);
      if (result != null) {
        user = result;
        error = null;
      } else {
        error = 'Kayıt başarısız! Bu email zaten kullanılıyor olabilir.';
      }
    } catch (e) {
      error = 'Bir hata oluştu: $e';
    }

    isLoading = false;
    notifyListeners();
  }

  void clearError() {
    error = null;
    notifyListeners();
  }
}
