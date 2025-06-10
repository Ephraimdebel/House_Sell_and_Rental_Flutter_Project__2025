import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../models/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> login(LoginModel loginModel);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Dio dio;

  LoginRemoteDataSourceImpl({required this.dio});

  @override
  Future<Either<Failure, Map<String, dynamic>>> login(
    LoginModel loginModel,
  ) async {
    try {
      final response = await dio.post(
        '/users/login',
        data: loginModel.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(
          ServerFailure(
            message: 'Login failed',
            statusCode: response.statusCode,
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          message: 'Login failed',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred'));
    }
  }
}
