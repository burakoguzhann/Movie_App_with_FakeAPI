import 'package:flutter/material.dart';
import 'package:movie_app/models/user_model.dart';
import 'package:movie_app/services/auth_service.dart';
import 'package:movie_app/view/login_view.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState(); // Düzeltildi!
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _authService = AuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _password = TextEditingController();

  void HandleRegister() async {
    final RegisterModel = UserModel(
      email: _emailController.text,
      password: _password.text,
    );

    try {
      await _authService.postRegister(RegisterModel);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Succesfully Register!')));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Unsuccessfully Register! $e')));
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
          // REGISTER yazısı
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 60),
              child: Text(
                'R E G I S T E R',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
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
          // Register formu
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
                            HandleRegister();
                          },
                          child: Text(
                            'Kayıt Ol',
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
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Zaten hesabın var mı? Giriş Yap',
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
