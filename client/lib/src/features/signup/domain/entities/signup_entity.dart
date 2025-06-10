class SignUpEntity {
  final String fullName;
  final String email;
  final String password;
  final String? phoneNumber;

  SignUpEntity({
    required this.fullName,
    required this.email,
    required this.password,
    this.phoneNumber,
  });
}
