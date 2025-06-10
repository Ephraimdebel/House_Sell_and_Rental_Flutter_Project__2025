import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/signup_entity.dart';
import '../../domain/repositories/signup_repository.dart';
import '../data_sources/signup_remote_data_source.dart';
import '../models/signup_model.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpRemoteDataSource remoteDataSource;

  SignUpRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> signUp(SignUpEntity signUpEntity) async {
    final signUpModel = SignUpModel.fromEntity(signUpEntity);
    return await remoteDataSource.signUp(signUpModel);
  }
}
