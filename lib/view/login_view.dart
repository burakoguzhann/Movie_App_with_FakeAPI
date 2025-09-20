import 'package:flutter/material.dart';
import 'package:movie_app/models/user_model.dart';
import 'package:movie_app/services/auth_service.dart';
import 'package:movie_app/view/home_view.dart';
import 'package:movie_app/view/register_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authService = AuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _password = TextEditingController();

  void HandleLogin() async {
    final LoginModel = UserModel(
      email: _emailController.text,
      password: _password.text,
    );

    try {
      await _authService.postLogin(LoginModel);
    } catch (e) {
      print('Hata $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Üst mavi alan
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Color.fromARGB(232, 9, 28, 51),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(75, 75),
                bottomRight: Radius.elliptical(75, 75),
              ),
            ),
          ),
          // LOGIN yazısı
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 60),
              child: Text(
                'L O G I N',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'YaziFont',
                  letterSpacing: 4,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: Offset(2, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Login formu
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail, color: Color.fromARGB(232, 9, 28, 51)),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Color.fromARGB(232, 9, 28, 51), width: 2),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Color.fromARGB(232, 9, 28, 51)),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.black54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Color.fromARGB(232, 9, 28, 51), width: 2),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(232, 9, 28, 51),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 5,
                          ),
                          onPressed: () {
                            HandleLogin();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
                          },
                          child: Text(
                            'Giriş Yap',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'TrajanPro',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterScreen()),
                          );
                        },
                        child: Text(
                          'Hesabın yok mu? Kayıt Ol',
                          style: TextStyle(
                            color: Color.fromARGB(232, 9, 28, 51),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
