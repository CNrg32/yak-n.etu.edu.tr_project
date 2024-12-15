// lib/login_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart'; // SharedPreferences'ı içe aktarın
import 'package:yakin_app/admin/admin_screen.dart';
import 'main_screen.dart'; // MainScreen'i içe aktarın
import 'signup_screen.dart'; // SignupScreen'i içe aktarın
import 'animated_background.dart'; // AnimatedBackground widget'ını içe aktarın

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _studentNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    String studentNumber = _studentNumberController.text.trim();
    String password = _passwordController.text.trim();

    if (studentNumber.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen tüm alanları doldurun')),
      );
      return;
    }

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(studentNumber)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        if (userData['password'] == password) {
          // Giriş başarılı, login değerini kaydet
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('login', true);
          await prefs.setString('studentNumber', studentNumber);

          if (userDoc.id == '0') {
            // Admin kullanıcı, AdminScreen'e yönlendir
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminScreen()),
            );
          } else {
            // Normal kullanıcı, MainScreen'e yönlendir
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Şifre yanlış')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kullanıcı bulunamadı')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Bir hata oluştu. Lütfen tekrar deneyin.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Arka planı Stack içinde yerleştiriyoruz
      body: Stack(
        children: [
          // AnimatedBackground widget'ını arka planda kullanıyoruz
          const AnimatedBackground(),
          // Form içeriklerini merkeze yerleştiriyoruz
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Başlık
                    const Text(
                      'Giriş Yap',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Öğrenci Numarası
                    TextField(
                      controller: _studentNumberController,
                      decoration: InputDecoration(
                        labelText: 'Öğrenci Numarası',
                        labelStyle: const TextStyle(color: Colors.blue),
                        filled: true,
                        fillColor: Colors.white24,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.blue, // Border rengini mavi yapıyoruz
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors
                                .blue, // Enabled durumunda border rengi mavi
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color:
                                Colors.lightBlue, // Focused durumda açık mavi
                            width: 2.0,
                          ),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    // Şifre
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Şifre',
                        labelStyle: const TextStyle(color: Colors.blue),
                        filled: true,
                        fillColor: Colors.white24,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.blue, // Border rengini mavi yapıyoruz
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors
                                .blue, // Enabled durumunda border rengi mavi
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color:
                                Colors.lightBlue, // Focused durumda açık mavi
                            width: 2.0,
                          ),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    // Giriş Butonu
                    ElevatedButton(
                      onPressed: _login,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors
                                  .lightBlue; // Butona basıldığında açık mavi
                            }
                            return Colors.white.withOpacity(
                                0.8); // Normal durumda beyaz opaklık
                          },
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 16),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Giriş Yap',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Kayıt Ol Butonu
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()),
                        );
                      },
                      child: const Text(
                        'Kayıt Ol',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
