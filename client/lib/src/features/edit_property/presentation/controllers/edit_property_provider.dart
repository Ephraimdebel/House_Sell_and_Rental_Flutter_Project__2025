import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/edit_property_usecase.dart';
import '../../data/repositories_impl/edit_property_repository_impl.dart';
import '../../data/datasources/edit_property_remote_datasource.dart';
import '../../../../core/network/dio_client.dart';
import 'edit_property_controller.dart';

final editPropertyControllerProvider = Provider<EditPropertyController>((ref) {
  final dio = ref.read(dioClientProvider);
  final dataSource = EditPropertyRemoteDataSource(dio: dio);
  final repository = EditPropertyRepositoryImpl(remoteDataSource: dataSource);
  final useCase = EditPropertyUseCase(repository: repository);

  return EditPropertyController(useCase: useCase);
});
