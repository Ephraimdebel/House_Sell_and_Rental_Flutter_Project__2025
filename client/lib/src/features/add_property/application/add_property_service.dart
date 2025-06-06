import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart'; // For MediaType
import '../domain/entities/new_property.dart';
import '../domain/repositories/add_property_repository.dart';

class AddPropertyService {
  final AddPropertyRepository repository;

  AddPropertyService(this.repository);

  Future<void> addProperty(NewProperty property) async {
    final List<MultipartFile> multipartImages = [];

    for (final path in property.photos) {
      if (path.isNotEmpty &&
          (path.endsWith('.jpg') ||
              path.endsWith('.jpeg') ||
              path.endsWith('.png') ||
              path.endsWith('.gif') ||
              path.endsWith('.webp'))) {
        final fileExtension = path.split('.').last;
        multipartImages.add(
          await MultipartFile.fromFile(
            path,
            filename: path.split('/').last,
            contentType: MediaType('image', fileExtension),
          ),
        );
      }
    }
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
      'photos': multipartImages,
    });

    await repository.addProperty(formData);
  }
}
