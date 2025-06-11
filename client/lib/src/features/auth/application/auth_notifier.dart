import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_rental_flutter/src/features/auth/application/auth_state.dart';
import 'package:house_rental_flutter/src/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:house_rental_flutter/src/features/auth/data/models/models.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthLocalDataSource localDataSource;

  AuthNotifier(this.localDataSource) : super(AuthState(isLoggedIn: false)) {
    _loadTokenAndUser();
  }

  Future<void> _loadTokenAndUser() async {
    final token = await localDataSource.getToken();
    if (token != null) {
      // TODO: Load user info here
      // For example, parse user info from storage or call API with token
      final user = await _fetchUser(token); // You implement this

      state = AuthState.loggedIn(token, user);
    }
  }

  Future<void> login(String token, User user) async {
    await localDataSource.saveToken(token);
    // Save user info if needed (e.g., in secure storage)
    state = AuthState.loggedIn(token, user);
  }

  Future<void> logout() async {
    await localDataSource.clearToken();
    // Clear user info storage if needed
    state = AuthState.loggedOut();
  }

  Future<User> _fetchUser(String token) async {
    // Implement API call or local storage fetch
    // Example stub:
    return User(email: 'example@email.com', role: 'user', avatarUrl: null);
  }
}
