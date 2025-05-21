import '../../domain/entities/property.dart';

class PropertyModel extends Property {
  PropertyModel({
    required super.id,
    required super.title,
    required super.city,
    required super.country,
    required super.price,
    required super.type,
    required super.isFeatured,
    required super.imageUrl,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      title: json['title'],
      city: json['city'],
      country: json['country'],
      price: json['price'],
      type: json['type_id'] == 1 ? 'For sale' : 'For rent',
      isFeatured: json['isFeatured'] == 1,
      imageUrl: json['listingPhotoPaths'][0],
    );
  }
}
