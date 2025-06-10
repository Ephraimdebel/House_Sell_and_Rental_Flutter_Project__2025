// models.dart
import '../../domain/entities/house_entity.dart';

class HouseModel extends HouseEntity {
  HouseModel({
    required super.id,
    required super.typeId,
    required super.title,// Make sure 'streetAddress' exists in HouseEntity's constructor, or rename to match the correct parameter name.
    required super.price,
  });

  factory HouseModel.fromJson(Map<String, dynamic> json) {
    return HouseModel(
      id: json['id'],
      typeId: json['type_id'],
      title: json['title'],
      price: json['price'],
    );
  }
}
