import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repsositories/login_repository.dart';
import '../data_sources/login_remote_data_source.dart';
import '../models/login_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Map<String, dynamic>>> login(
    LoginEntity loginEntity,
  ) async {
    final loginModel = LoginModel.fromEntity(loginEntity);
    return await remoteDataSource.login(loginModel);
  }
}
