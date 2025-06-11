import 'package:flutter/material.dart';
import 'package:house_rental_flutter/src/features/home/domain/entities/home_entitiy.dart';


class FeaturedProperties extends StatelessWidget {
  final List<Property> properties;

  const FeaturedProperties({
    super.key,
    required this.properties,
  });

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) return const SizedBox();

    return SizedBox(
      height: 400,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: properties.length,
        padding: const EdgeInsets.only(right: 16),
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final property = properties[index];
          return SizedBox(
          width: MediaQuery.of(context).size.width * 0.85, // Show 1.5 cards at once
          child: FeaturedTile(property: property),
        );
        },
      ),
    );
  }
}


class FeaturedTile extends StatelessWidget {
  final Property property;

  const FeaturedTile({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              property.listingPhotoPaths.isNotEmpty 
                  ? property.listingPhotoPaths.first 
                  : 'https://via.placeholder.com/250x150',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ETB ${property.price.toStringAsFixed(2)}${property.typeId == 2 ? '/mo' : ''}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  property.title,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  '${property.streetAddress}, ${property.city}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.king_bed, size: 14),
                    Text(' ${property.bedroomCount}'),
                    const SizedBox(width: 8),
                    const Icon(Icons.bathtub, size: 14),
                    Text(' ${property.bathroomCount}'),
                    const SizedBox(width: 8),
                    const Icon(Icons.square_foot, size: 14),
                    Text(' ${property.area}ft²'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}