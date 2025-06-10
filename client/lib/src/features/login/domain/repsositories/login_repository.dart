import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, Map<String, dynamic>>> login(LoginEntity loginEntity);
}
