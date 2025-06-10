import '../../domain/entities/signup_entity.dart';

class SignUpModel extends SignUpEntity {
  SignUpModel({
    required super.fullName,
    required super.email,
    required super.password,
    super.phoneNumber,
  });

  factory SignUpModel.fromEntity(SignUpEntity entity) {
    return SignUpModel(
      fullName: entity.fullName,
      email: entity.email,
      password: entity.password,
      phoneNumber: entity.phoneNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'password': password,
      if (phoneNumber != null) 'phone_number': phoneNumber,
    };
  }
}
