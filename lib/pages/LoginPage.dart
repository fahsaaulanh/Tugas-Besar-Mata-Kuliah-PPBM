import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field_form.dart';
import 'package:chat_app/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      Get.snackbar('Sorry', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient untuk seluruh halaman
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFF9596),
                  Color(0xFF9A73FF),
                  Color(0xFF9A73FF)
                ], // Warna gradien
              ),
            ),
          ),

          Positioned(
            top: 80, // Jarak dari atas layar
            left: 0,
            right: 0,
            child: Text(
              "Welcome Back!", // Teks di luar box
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    blurRadius: 5,
                  ),
                ],
              ),
            ),
          ),

          // Konten dengan background putih dan sudut melengkung
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height *
                  0.75, // Atur tinggi sesuai kebutuhan
              decoration: const BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFE7CBE8),
                    Color(0xFFD5C6F9),
                    Color(0xFAD5C6F9),
                    Color(0xAAE7CBE8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      "Login You're Account",
                      style: TextStyle(
                          color: Color(0xFF060088),
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 25),
                    // Email TextField
                    MyTextFieldForm(
                      controller: emailController,
                      hintText: 'Email',
                      obsecureText: false,
                    ),
                    const SizedBox(height: 10),
                    // Password TextField
                    MyTextFieldForm(
                      controller: passwordController,
                      hintText: 'Password',
                      obsecureText: true,
                    ),
                    const SizedBox(height: 20),
                    // Sign-In Button
                    MyButton(onTap: signIn, text: 'Sign In', icon: Icons.login),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Not a member?'),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Register Now',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF84669)),
                          ),
                        )
                      ],
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
