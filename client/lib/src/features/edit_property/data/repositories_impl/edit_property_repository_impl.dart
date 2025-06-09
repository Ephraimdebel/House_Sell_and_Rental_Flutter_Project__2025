import '../../domain/entities/editable_property.dart';
import '../../domain/repositories/edit_property_repository.dart';
import '../datasources/edit_property_remote_datasource.dart';
import '../models/editable_property.dart';

class EditPropertyRepositoryImpl implements EditPropertyRepository {
  final EditPropertyRemoteDataSource remoteDataSource;

  EditPropertyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<EditableProperty> fetchProperty(int id) async {
    final model = await remoteDataSource.fetchProperty(id);
    return EditableProperty.fromModel(model);
  }

  @override
  Future<void> updateProperty(int id, EditableProperty property) async {
    final model = EditablePropertyModel.fromEntity(property);
    await remoteDataSource.updateProperty(id, model);
  }
}
