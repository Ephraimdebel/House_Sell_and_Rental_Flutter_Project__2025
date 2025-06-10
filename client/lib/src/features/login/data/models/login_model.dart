import '../../domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({required super.email, required super.password});

  factory LoginModel.fromEntity(LoginEntity entity) {
    return LoginModel(email: entity.email, password: entity.password);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
