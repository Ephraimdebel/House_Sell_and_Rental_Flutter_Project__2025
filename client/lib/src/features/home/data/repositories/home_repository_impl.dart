

import 'package:house_rental_flutter/src/core/errors/failures.dart';
import 'package:house_rental_flutter/src/core/exceptions/exceptions.dart';
import 'package:house_rental_flutter/src/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:house_rental_flutter/src/features/home/domain/entities/home_entitiy.dart';
import 'package:house_rental_flutter/src/features/home/domain/repositories/home_repository.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyRemoteDataSource remoteDataSource;

  PropertyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Property>> getProperties() async {
    try {
      return await remoteDataSource.getProperties();
    } on ServerException {
      throw ServerFailure(message: 'Failed to fetch properties');
    }
  }

  @override
  Future<List<Property>> getFeaturedProperties() async {
    try {
      final properties = await remoteDataSource.getProperties();
      return properties.where((property) => property.isFeatured).toList();
    } on ServerException {
      throw ServerFailure(message: 'Failed to fetch featured properties');
    }
  }
}