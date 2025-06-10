import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../../core/errors/failures.dart';
import '../domain/usecases/signup_usecase.dart';
import '../domain/entities/signup_entity.dart';
import '../presentation/providers/signup_providers.dart';

class SignUpService {
  final SignUpUseCase signUpUseCase;

  SignUpService({required this.signUpUseCase});

  Future<Either<Failure, String>> signUp({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    String? phoneNumber,
  }) async {
    if (password != confirmPassword) {
      return Left(ServerFailure('Passwords do not match'));
    }

    final signUpEntity = SignUpEntity(
      fullName: fullName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    );

    return await signUpUseCase.execute(signUpEntity);
  }
}

final signUpServiceProvider = Provider<SignUpService>((ref) {
  final signUpUseCase = ref.read(signUpUseCaseProvider);
  return SignUpService(signUpUseCase: signUpUseCase);
});
