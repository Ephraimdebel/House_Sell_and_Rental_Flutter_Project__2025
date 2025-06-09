
import '../entities/editable_property.dart';

abstract class EditPropertyRepository {
  Future<EditableProperty> fetchProperty(int id);
  Future<void> updateProperty(int id, EditableProperty property);
}