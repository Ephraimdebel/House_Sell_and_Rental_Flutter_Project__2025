import 'package:dio/dio.dart';
import 'package:house_rental_flutter/src/features/edit_property/domain/entities/editable_property.dart';
import '../domain/entities/new_property.dart';
import '../domain/repositories/edit_property_repository.dart';

class EditPropertyService {
  final EditPropertyRepository repository;

  EditPropertyService(this.repository);

  Future<void> updateProperty(String id, NewProperty property) async {
    final formData = FormData.fromMap({
      'category': property.category,
      'type': property.type,
      'title': property.title,
      'description': property.description,
      'price': property.price,
      'bedroomCount': property.bedroomCount,
      'bathroomCount': property.bathroomCount,
      'area': property.area,
      'streetAddress': property.streetAddress,
      'city': property.city,
      'province': property.province,
      'country': property.country,
      'facilities': property.facilities,
      'photos': [
        for (final path in property.photos)
          await MultipartFile.fromFile(path, filename: path.split('/').last),
      ],
    });

    await repository.updateProperty(id as int, formData as EditableProperty);
  }
}
