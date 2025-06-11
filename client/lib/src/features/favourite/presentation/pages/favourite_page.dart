import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/favourite_controller.dart';
import '../../domain/entities/favourite.dart';

class FavouritePage extends ConsumerWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Replace 1 with actual userId once auth is ready
    final favouriteState = ref.watch(favouriteControllerProvider(1));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Favourites'),
        // centerTitle: true,
        backgroundColor: Colors.white,
        // foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: favouriteState.when(
        data: (favourites) {
          if (favourites.isEmpty) {
            return const Center(child: Text("No favourites yet."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favourites.length,
            itemBuilder: (context, index) {
              final favourite = favourites[index];
              final rawImageUrl = favourite.photos.first;
              final imageUrl = rawImageUrl.replaceFirst(
                'localhost',
                '10.0.2.2',
              );

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.7),
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            favourite.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${favourite.city}, ${favourite.country}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.bed_outlined, size: 18),
                              const SizedBox(width: 4),
                              Text("${favourite.bedroomCount} Beds"),
                              const SizedBox(width: 16),
                              Icon(Icons.bathtub_outlined, size: 18),
                              const SizedBox(width: 4),
                              Text("${favourite.bathroomCount} Baths"),
                              const SizedBox(width: 16),
                              Icon(Icons.square_foot, size: 18),
                              const SizedBox(width: 4),
                              Text("${favourite.area} sqft"),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "\$${favourite.price}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
