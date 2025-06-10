import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/signup_entity.dart';
import '../repositories/signup_repository.dart';

class SignUpUseCase {
  final SignUpRepository signUpRepository;

  SignUpUseCase(this.signUpRepository);

  Future<Either<Failure, String>> execute(SignUpEntity signUpEntity) async {
    return await signUpRepository.signUp(signUpEntity);
  }
}
