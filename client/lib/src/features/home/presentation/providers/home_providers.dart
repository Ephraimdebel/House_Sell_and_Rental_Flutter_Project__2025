

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_rental_flutter/src/core/network/dio_client.dart';
import 'package:house_rental_flutter/src/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:house_rental_flutter/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:house_rental_flutter/src/features/home/domain/entities/home_entitiy.dart';
import 'package:house_rental_flutter/src/features/home/domain/repositories/home_repository.dart';
import 'package:house_rental_flutter/src/features/home/domain/usecases/get_home_data.dart';

final propertiesProvider = FutureProvider<List<Property>>((ref) async {
  final getProperties = ref.watch(getPropertiesProvider);
  return await getProperties();
});

final getPropertiesProvider = Provider<GetProperties>((ref) {
  return GetProperties(repository: ref.watch(propertyRepositoryProvider));
});

final propertyRepositoryProvider = Provider<PropertyRepository>((ref) {
  return PropertyRepositoryImpl(
    remoteDataSource: PropertyRemoteDataSourceImpl(
      dio: ref.watch(dioClientProvider),
    ),
  );
});