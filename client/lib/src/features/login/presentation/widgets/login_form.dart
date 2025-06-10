// lib/features/login/presentation/widgets/login_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/providers/login_providers.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginStateProvider);
    // Define the light blue color
    const lightBlue = Color(
      0xFF64B5F6,
    ); // You can adjust this color code as needed

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            'Welcome Back',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Sign in to your account',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 32),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Navigate to forgot password screen
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(color: lightBlue),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: lightBlue, // Background color
              foregroundColor: Colors.white, // Text color
              minimumSize: const Size(double.infinity, 50), // Full width
            ),
            onPressed:
                loginState.isLoading
                    ? null
                    : () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(loginStateProvider.notifier)
                            .login(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                      }
                    },
            child:
                loginState.isLoading
                    ? const CircularProgressIndicator(
                      color: Colors.white, // White loading indicator
                    )
                    : const Text('Sign In'),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              // Navigate to sign up screen
            },
            child: const Text.rich(
              TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(
                  color: Color.fromARGB(
                    255,
                    8,
                    8,
                    8,
                  ), // Grey color for the text
                ),
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: lightBlue, // Light blue color for Sign Up
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (loginState.hasError)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                loginState.error.toString(),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
        ],
      ),
    );
  }
}
