// models.dart
class User {
  final String email;
  final String role;
  final String? avatarUrl;

  User({required this.email, required this.role, this.avatarUrl});
}
