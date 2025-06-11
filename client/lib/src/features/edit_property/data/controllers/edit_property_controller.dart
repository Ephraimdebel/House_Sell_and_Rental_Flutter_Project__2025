import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_rental_flutter/src/features/edit_property/domain/entities/editable_property.dart';
import '../../data/models/editable_property.dart';
import '../../../../core/network/dio_client.dart';

class EditPropertyController {
  final Dio dio;

  EditPropertyController(this.dio);

  Future<EditableProperty> fetchProperty(int id) async {
    try {
      final response = await dio.get('/house/$id');
      return EditableProperty.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load property: $e');
    }
  }

  Future<void> updateProperty(int id, EditableProperty property) async {
    try {
      final data = {
        "category": property.category,
        "type": property.type,
        "title": property.title,
        "description": property.description,
        "price": property.price,
        "bedroomCount": property.bedroomCount,
        "bathroomCount": property.bathroomCount,
        "area": property.area,
        "streetAddress": property.streetAddress,
        "city": property.city,
        "province": property.province,
        "country": property.country,
        "facilities": property.facilities,
        "photos": property.photos,
      };

      await dio.patch('/listings/$id', data: data);
    } catch (e) {
      throw Exception('Failed to update property: $e');
    }
  }
}
