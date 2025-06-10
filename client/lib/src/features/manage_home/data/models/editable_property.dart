// class EditableProperty {
//   final int id;
//   final int category;
//   final int type;
//   final String streetAddress;
//   final String city;
//   final String province;
//   final String country;
//   final int bedroomCount;
//   final int bathroomCount;
//   final String title;
//   final String description;
//   final String price;
//   final int area;
//   final List<int> facilities;
//   final List<String> photos;

//   EditableProperty({
//     required this.id,
//     required this.category,
//     required this.type,
//     required this.streetAddress,
//     required this.city,
//     required this.province,
//     required this.country,
//     required this.bedroomCount,
//     required this.bathroomCount,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.area,
//     required this.facilities,
//     required this.photos,
//   });

//   factory EditableProperty.fromPropertyModel(PropertyModel model) {
//     return EditableProperty(
//       id: model.id,
//       category: model.categoryId,
//       type: model.typeId,
//       streetAddress: model.streetAddress,
//       city: model.city,
//       province: model.province,
//       country: model.country,
//       bedroomCount: model.bedroomCount,
//       bathroomCount: model.bathroomCount,
//       title: model.title,
//       description: model.description,
//       price: model.price,
//       area: model.area,
//       facilities: model.facilities?.split(',').map(int.parse).toList() ?? [],
//       photos: model.listingPhotoPaths ?? [],
//     );
//   }
// }
