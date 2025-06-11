import '../../domain/entities/favourite.dart';

class FavouriteModel extends Favourite {
  FavouriteModel({
    required int id,
    required String title,
    required String description,
    required String country,
    required String city,
    required String streetAddress,
    required int bedroomCount,
    required int bathroomCount,
    required int area,
    required String price,
    required List<String> photos,
  }) : super(
          id: id,
          title: title,
          description: description,
          country: country,
          city: city,
          streetAddress: streetAddress,
          bedroomCount: bedroomCount,
          bathroomCount: bathroomCount,
          area: area,
          price: price,
          photos: photos,
        );

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      country: json['country'],
      city: json['city'],
      streetAddress: json['streetAddress'],
      bedroomCount: json['bedroomCount'],
      bathroomCount: json['bathroomCount'],
      area: json['area'],
      price: json['price'],
      photos: List<String>.from(json['listingPhotoPaths'] ?? []),
    );
  }
}
