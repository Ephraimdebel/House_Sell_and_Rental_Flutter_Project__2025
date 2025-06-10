import '../entities/home_entitiy.dart';
import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<HouseEntity>>> getFeaturedHouses();
}
