// lib/features/signup/presentation/controllers/signup_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/providers/signup_providers.dart';

class SignUpController {
  final Ref ref;

  SignUpController(this.ref);

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    String? phoneNumber,
  }) async {
    await ref
        .read(signUpStateProvider.notifier)
        .signUp(
          fullName: fullName,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          phoneNumber: phoneNumber,
        );
  }
}
