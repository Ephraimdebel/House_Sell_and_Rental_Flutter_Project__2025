import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../../core/errors/failures.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/entities/login_entity.dart';
import '../presentation/providers/login_providers.dart';

class LoginService {
  final LoginUseCase loginUseCase;

  LoginService({required this.loginUseCase});

  Future<Either<Failure, Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    final loginEntity = LoginEntity(email: email, password: password);

    return await loginUseCase.execute(loginEntity);
  }
}

final loginServiceProvider = Provider<LoginService>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  return LoginService(loginUseCase: loginUseCase);
});
