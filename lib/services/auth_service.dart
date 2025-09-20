import 'package:movie_app/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<UserModel?> postLogin(UserModel loginModel) async {
    final url = Uri.parse('https://api.escuelajs.co/api/v1/auth/login'); // Doğru endpoint

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'email': loginModel.email,
          'password': loginModel.password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data); // UserModel döndür
      } else {
        return null; // Başarısızsa null döndür
      }
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<UserModel?> postRegister(UserModel registerModel) async {
    final url = Uri.parse('https://api.escuelajs.co/api/v1/users'); // Bu doğru

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(registerModel.toJson()),
      );

      if (response.statusCode == 201) { // Register genellikle 201 döner
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data); // UserModel döndür
      } else {
        return null; // Başarısızsa null döndür
      }
    } catch (e) {
      print('Register error: $e');
      return null;
    }
  }
}
