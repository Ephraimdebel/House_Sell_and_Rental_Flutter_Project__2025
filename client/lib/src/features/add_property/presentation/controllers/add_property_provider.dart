import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../application/add_property_service.dart';
import '../../data/datasources/add_property_remote_datasource.dart';
import '../../data/repositories_impl/add_property_repository_impl.dart';
import '../../domain/entities/new_property.dart';

final addPropertyControllerProvider = Provider<AddPropertyService>((ref) {
  final dio = ref.watch(dioClientProvider);
  final datasource = AddPropertyRemoteDataSource(dio);
  final repository = AddPropertyRepositoryImpl(datasource);
  return AddPropertyService(repository);
});
