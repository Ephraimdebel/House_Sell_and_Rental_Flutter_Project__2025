// entities.dart
class UserEntity {
  final int id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String role;

  UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.role,
  });
}
