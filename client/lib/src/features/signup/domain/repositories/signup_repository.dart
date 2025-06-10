import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/signup_entity.dart';

abstract class SignUpRepository {
  Future<Either<Failure, String>> signUp(SignUpEntity signUpEntity);
}
