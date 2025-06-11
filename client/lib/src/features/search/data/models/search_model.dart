import '../../domain/entities/search_result.dart';

class SearchModel extends SearchResult {
  SearchModel({
    required super.id,
    required super.title,
    required super.city,
    required super.country,
    required super.bedroomCount,
    required super.bathroomCount,
    required super.area,
    required super.price,
    required super.photos,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'],
      title: json['title'],
      city: json['city'],
      country: json['country'],
      bedroomCount: json['bedroomCount'] is String
          ? int.parse(json['bedroomCount'])
          : json['bedroomCount'],
      bathroomCount: json['bathroomCount'] is String
          ? int.parse(json['bathroomCount'])
          : json['bathroomCount'],
      area: json['area'] is String
          ? double.parse(json['area'])
          : (json['area'] as num).toDouble(),
      price: json['price'] is String
          ? double.parse(json['price'])
          : (json['price'] as num).toDouble(),
      photos: (json['listingPhotoPaths'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}
