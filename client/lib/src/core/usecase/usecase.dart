import 'package:dartz/dartz.dart';
import '../errors/failures.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Used when a UseCase doesn’t need any input.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
