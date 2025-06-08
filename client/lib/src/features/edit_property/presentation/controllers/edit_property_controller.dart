import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../application/edit_property_service.dart';
import '../../data/datasources/edit_property_remote_datasource.dart';
import '../../data/repositories_impl/edit_property_repository_impl.dart';

final editPropertyControllerProvider = Provider<EditPropertyService>((ref) {
  final dio = ref.watch(dioClientProvider);
  final datasource = EditPropertyRemoteDataSource(dio);
  final repository = EditPropertyRepositoryImpl(datasource);
  return EditPropertyService(repository);
});
