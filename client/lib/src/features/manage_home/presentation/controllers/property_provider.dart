import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/property_service.dart';
import '../../data/datasources/property_remote_datasource.dart';
import '../../data/repositories_impl/property_repository_impl.dart';
import '../../domain/entities/property.dart';
import '../../../../core/network/dio_client.dart';

/// 👇 Fetch all properties
final propertyProvider = FutureProvider<List<Property>>((ref) async {
  final dio = ref.watch(dioClientProvider);
  final datasource = PropertyRemoteDataSource(dio);
  final repo = PropertyRepositoryImpl(datasource);
  final service = PropertyService(repo);
  return service.getAllProperties();
});

/// 👇 Expose PropertyService for delete or other use
final propertyControllerProvider = Provider<PropertyService>((ref) {
  final dio = ref.watch(dioClientProvider);
  final datasource = PropertyRemoteDataSource(dio);
  final repo = PropertyRepositoryImpl(datasource);
  return PropertyService(repo);
});
