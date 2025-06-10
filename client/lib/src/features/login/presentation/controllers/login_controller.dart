// lib/features/login/presentation/controllers/login_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/providers/login_providers.dart';

class LoginController {
  final Ref ref;

  LoginController(this.ref);

  Future<void> login({required String email, required String password}) async {
    await ref
        .read(loginStateProvider.notifier)
        .login(email: email, password: password);
  }
}
