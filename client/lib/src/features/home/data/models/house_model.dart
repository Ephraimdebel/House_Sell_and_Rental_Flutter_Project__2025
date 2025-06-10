import '../../domain/entities/home_entitiy.dart';

class HouseModel extends HouseEntity {
  const HouseModel({
    required int id,
    required String title,
    required String city,
    required String price,
    required List<String> images,
  }) : super(id: id, title: title, city: city, price: price, images: images);

  factory HouseModel.fromJson(Map<String, dynamic> json) {
    return HouseModel(
      id: json['id'],
      title: json['title'],
      city: json['city'],
      price: json['price'],
      images: List<String>.from(json['listingPhotoPaths']),
    );
  }
}
