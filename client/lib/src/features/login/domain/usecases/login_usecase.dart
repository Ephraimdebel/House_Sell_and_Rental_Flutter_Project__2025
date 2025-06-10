import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/login_entity.dart';
import '../repsositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase(this.loginRepository);

  Future<Either<Failure, Map<String, dynamic>>> execute(
    LoginEntity loginEntity,
  ) async {
    return await loginRepository.login(loginEntity);
  }
}
