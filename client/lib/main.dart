// lib/features/signup/presentation/widgets/signup_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
<<<<<<< HEAD
import '../../presentation/providers/signup_providers.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
=======
import 'package:house_rental_flutter/src/features/admin_dashboard/presentation/pages/admin_dashboard_page.dart';
import 'package:house_rental_flutter/src/features/manage_users/presentation/pages/manage_users_page.dart';
import 'package:house_rental_flutter/src/features/profile/presentation/pages/profile_page.dart';
import 'src/features/manage_home/presentation/pages/manage_home_page.dart';
import 'src/features/add_property/presentation/pages/add_property_page.dart';
void main() {
  runApp(const ProviderScope(child: MyApp()));
>>>>>>> 41180fa37550cc1eb672f395a69487074f62355c
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpStateProvider);
    const lightBlue = Color(0xFF64B5F6); // Define light blue color

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _fullNameController,
            decoration: const InputDecoration(
              labelText: 'Enter your full name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Enter your email',
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
              labelText: 'Create a password',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm your password',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _phoneNumberController,
            decoration: const InputDecoration(
              labelText: 'Phone number (optional)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: lightBlue, // Light blue background
              foregroundColor: Colors.white, // White text
              minimumSize: const Size(double.infinity, 50), // Full width button
            ),
            onPressed:
                signUpState.isLoading
                    ? null
                    : () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(signUpStateProvider.notifier)
                            .signUp(
                              fullName: _fullNameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              confirmPassword: _confirmPasswordController.text,
                              phoneNumber:
                                  _phoneNumberController.text.isEmpty
                                      ? null
                                      : _phoneNumberController.text,
                            );
                      }
                    },
            child:
                signUpState.isLoading
                    ? const CircularProgressIndicator(
                      color: Colors.white, // White loading indicator
                    )
                    : const Text('Sign Up'),
          ),
          if (signUpState.hasError)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                signUpState.error.toString(),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          if (signUpState.hasValue && signUpState.value != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                signUpState.value!,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
        ],
      ),
<<<<<<< HEAD
=======
      home: AdminDashboardPage(),
>>>>>>> 41180fa37550cc1eb672f395a69487074f62355c
    );
  }
}
