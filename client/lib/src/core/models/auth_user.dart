class AuthUser {
  final String token;
  final String username;
  final int userid;
  final String role;
  final String email;

  AuthUser({
    required this.token,
    required this.username,
    required this.userid,
    required this.role,
    required this.email,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      token: json['token'],
      username: json['username'],
      userid: json['userid'],
      role: json['role'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'username': username,
      'userid': userid,
      'role': role,
      'email': email,
    };
  }
}
