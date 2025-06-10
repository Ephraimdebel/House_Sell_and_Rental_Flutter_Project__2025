import '../entities/editable_property.dart';
import '../repositories/edit_property_repository.dart';

class EditPropertyUseCase {
  final EditPropertyRepository repository;

  EditPropertyUseCase({required this.repository});

  Future<EditableProperty> fetchProperty(int id) => repository.fetchProperty(id);
  Future<void> updateProperty(int id, EditableProperty property) => repository.updateProperty(id, property);
}