import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/editable_property.dart';
import '../../domain/usecases/edit_property_usecase.dart';
import '../../data/datasources/edit_property_remote_datasource.dart';
import '../../data/repositories_impl/edit_property_repository_impl.dart';

class EditPropertyController {
  final EditPropertyUseCase useCase;

  EditPropertyController({required this.useCase});

  Future<EditableProperty> fetchProperty(int id) {
    return useCase.fetchProperty(id);
  }

  Future<void> updateProperty(int id, EditableProperty property) {
    return useCase.updateProperty(id, property);
  }
}

// Provider
final editPropertyControllerProvider = Provider<EditPropertyController>((ref) {
  final dataSource = ref.read(editPropertyRemoteDataSourceProvider);
  final repository = EditPropertyRepositoryImpl(remoteDataSource: dataSource);
  final useCase = EditPropertyUseCase(repository: repository);
  return EditPropertyController(useCase: useCase);
});
