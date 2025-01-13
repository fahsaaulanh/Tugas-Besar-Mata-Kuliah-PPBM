import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field_form.dart';
import 'package:chat_app/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Sorry', 'Passwords do not match!');
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailAndPassword(
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
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFF9596),
                  Color(0xFF9A73FF),
                  Color(0xFF9A73FF)
                ],
              ),
            ),
          ),

          // Top text
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Text(
              "Create Account", // Adjusted text for register
              textAlign: TextAlign.center,
              style: const TextStyle(
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

          // Main content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
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
                      "Register Your Account",
                      style: TextStyle(
                        color: Color(0xFF060088),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
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
                    const SizedBox(height: 10),
                    // Confirm Password TextField
                    MyTextFieldForm(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obsecureText: true,
                    ),
                    const SizedBox(height: 20),
                    // Sign-Up Button
                    MyButton(onTap: signUp, text: 'Sign Up', icon: Icons.login),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Login Now',
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
