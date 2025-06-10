import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../models/signup_model.dart';

abstract class SignUpRemoteDataSource {
  Future<Either<Failure, String>> signUp(SignUpModel signUpModel);
}

class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  final Dio dio;

  SignUpRemoteDataSourceImpl({required this.dio});

  @override
  Future<Either<Failure, String>> signUp(SignUpModel signUpModel) async {
    try {
      final response = await dio.post(
        '/users/register',
        data: signUpModel.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data['message']);
      } else {
        return Left(ServerFailure(response.data['message'] ?? 'Signup failed'));
      }
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data['message'] ?? e.message ?? 'Signup failed',
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred'));
    }
  }
}
