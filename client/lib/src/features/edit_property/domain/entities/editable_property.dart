
class EditableProperty {
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

  EditableProperty({
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

  factory EditableProperty.fromModel(dynamic model) => EditableProperty(
        id: model.id,
        category: model.category,
        type: model.type,
        title: model.title,
        description: model.description,
        price: model.price,
        bedroomCount: model.bedroomCount,
        bathroomCount: model.bathroomCount,
        area: model.area,
        streetAddress: model.streetAddress,
        city: model.city,
        province: model.province,
        country: model.country,
        photos: model.photos,
        facilities: model.facilities,
      );
}