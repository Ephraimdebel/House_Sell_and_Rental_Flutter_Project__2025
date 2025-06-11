import 'package:house_rental_flutter/src/features/auth/data/models/models.dart';

class AuthState {
  final bool isLoggedIn;
  final String? token;
  final User? user;  // add user here

  AuthState({required this.isLoggedIn, this.token, this.user});

  factory AuthState.loggedIn(String token, User user) =>
      AuthState(isLoggedIn: true, token: token, user: user);

  factory AuthState.loggedOut() => AuthState(isLoggedIn: false, user: null);
}
