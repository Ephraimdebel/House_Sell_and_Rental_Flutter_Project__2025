// models.dart
import '../../domain/entities/house_entity.dart';

class HouseModel extends HouseEntity {
  HouseModel({
    required super.id,
    required super.typeId,
    required super.title,
    required super.city,
    required super.streetAddress,
    required super.price,
    required super.isFeatured,
  });

  factory HouseModel.fromJson(Map<String, dynamic> json) {
    return HouseModel(
      id: json['id'],
      typeId: json['type_id'],
      title: json['title'],
      city: json['city'],
      streetAddress: json['streetAddress'],
      price: json['price'],
      isFeatured: json['isFeatured'] == 1,
    );
  }
}
