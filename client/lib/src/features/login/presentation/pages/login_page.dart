// lib/features/login/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        foregroundColor: const Color(
          0xFF64B5F6,
        ), // Light blue color for AppBar contents
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: const [SizedBox(height: 32), LoginForm()]),
      ),
    );
  }
}
