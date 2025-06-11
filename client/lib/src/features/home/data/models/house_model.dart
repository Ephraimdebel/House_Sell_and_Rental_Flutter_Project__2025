

import 'package:equatable/equatable.dart';
import 'package:house_rental_flutter/src/features/home/domain/entities/home_entitiy.dart';

class PropertyModel extends Property {
  PropertyModel({
    required super.id,
    required super.title,
    required super.description,
    required super.streetAddress,
    required super.city,
    required super.province,
    required super.country,
    required super.price,
    required super.bedroomCount,
    required super.bathroomCount,
    required super.area,
    required super.listingPhotoPaths,
    required super.typeId,
    required super.isFeatured,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      streetAddress: json['streetAddress'],
      city: json['city'],
      province: json['province'],
      country: json['country'],
      price: double.parse(json['price']),
      bedroomCount: json['bedroomCount'],
      bathroomCount: json['bathroomCount'],
      area: json['area'],
      listingPhotoPaths: List<String>.from(json['listingPhotoPaths']),
      typeId: json['type_id'],
      isFeatured: json['isFeatured'] == 1,
    );
  }

  @override
  List<Object?> get props => [id];
}