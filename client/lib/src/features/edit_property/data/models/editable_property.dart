import 'package:equatable/equatable.dart';
import '../../domain/entities/editable_property.dart';

class EditablePropertyModel extends Equatable {
  final int id;
  final String category;
  final String type;
  final String title;
  final String description;
  final double price;
  final int bedroomCount;
  final int bathroomCount;
  final double area;
  final String streetAddress;
  final String city;
  final String province;
  final String country;
  final List<String> photos;
  final List<int> facilities;

  EditablePropertyModel({
    required this.id,
    required this.category,
    required this.type,
    required this.title,
    required this.description,
    required this.price,
    required this.bedroomCount,
    required this.bathroomCount,
    required this.area,
    required this.streetAddress,
    required this.city,
    required this.province,
    required this.country,
    required this.photos,
    required this.facilities,
  });

  // Factory constructor to create model from JSON
  factory EditablePropertyModel.fromJson(Map<String, dynamic> json) {
    // Convert facilities string like "1,2,3" to List<int>
    List<int> facilitiesList = [];
    if (json['facilities'] != null) {
      facilitiesList = (json['facilities'] as String)
          .split(',')
          .map((e) => int.tryParse(e.trim()) ?? 0)
          .where((e) => e != 0)
          .toList();
    }

    // photos might be List<dynamic> from JSON, convert to List<String>
    List<String> photosList = [];
    if (json['listingPhotoPaths'] != null) {
      photosList = List<String>.from(json['listingPhotoPaths']);
    }

    return EditablePropertyModel(
      id: json['id'],
      category: json['category_id'].toString(),
      type: json['type_id'].toString(),
      title: json['title'],
      description: json['description'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      bedroomCount: json['bedroomCount'],
      bathroomCount: json['bathroomCount'],
      area: (json['area'] as num).toDouble(),
      streetAddress: json['streetAddress'],
      city: json['city'],
      province: json['province'],
      country: json['country'],
      photos: photosList,
      facilities: facilitiesList,
    );
  }

  // Convert model back to JSON for update
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': int.tryParse(category) ?? 0,
      'type_id': int.tryParse(type) ?? 0,
      'title': title,
      'description': description,
      'price': price.toString(),
      'bedroomCount': bedroomCount,
      'bathroomCount': bathroomCount,
      'area': area,
      'streetAddress': streetAddress,
      'city': city,
      'province': province,
      'country': country,
      'listingPhotoPaths': photos,
      'facilities': facilities.join(','), // convert list back to CSV string
    };
  }

  // **Here is the missing fromEntity factory constructor:**
  factory EditablePropertyModel.fromEntity(EditableProperty entity) {
    return EditablePropertyModel(
      id: entity.id,
      category: entity.category,
      type: entity.type,
      title: entity.title,
      description: entity.description,
      price: entity.price,
      bedroomCount: entity.bedroomCount,
      bathroomCount: entity.bathroomCount,
      area: entity.area,
      streetAddress: entity.streetAddress,
      city: entity.city,
      province: entity.province,
      country: entity.country,
      photos: entity.photos,
      facilities: entity.facilities,
    );
  }

  @override
  List<Object?> get props => [
        id,
        category,
        type,
        title,
        description,
        price,
        bedroomCount,
        bathroomCount,
        area,
        streetAddress,
        city,
        province,
        country,
        photos,
        facilities,
      ];
}
