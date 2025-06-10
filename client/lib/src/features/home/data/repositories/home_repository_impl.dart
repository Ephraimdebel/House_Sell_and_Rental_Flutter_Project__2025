// import '../../domain/repositories/home_repository.dart';
// import '../../domain/entities/home_entitiy.dart';
// import '../data_sources/home_remote_data_source.dart';
// import '../../../../core/errors/failures.dart';
// import 'package:dartz/dartz.dart';

// class HomeRepositoryImpl implements HomeRepository {
//   final HomeRemoteDataSource remoteDataSource;

//   HomeRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<Either<Failure, List<HouseEntity>>> getFeaturedHouses() async {
//     try {
//       final houses = await remoteDataSource.getFeaturedHouses();
//       return Right(houses);
//     } on ServerFailure catch (e) {
//       return Left(e);
//     } catch (e) {
//       return Left(ServerFailure(message: 'Unexpected error: ${e.toString()}'));
//     }
//   }
// }
