// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/home_providers.dart';
// import '../../domain/entities/home_entitiy.dart';


// class HomePage extends ConsumerWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final homeState = ref.watch(homeControllerProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       body: homeState.when(
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, stack) => Center(child: Text('Error: $error')),
//         data: (homeData) => SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               const Text('Home', style: TextStyle(fontSize: 24)),
//               const SizedBox(height: 20),
//               Text(homeData.greeting, style: const TextStyle(fontSize: 18)),
//               const SizedBox(height: 20),
//               Text('Email: ${homeData.email}'),
//               const SizedBox(height: 20),
//               const Text('Featured Houses', style: TextStyle(fontSize: 20)),
//               const SizedBox(height: 10),
//               ...homeData.featuredHouses.map((house) => HouseCard(house: house)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HouseCard extends StatelessWidget {
//   final HouseEntity house;

//   const HouseCard({super.key, required this.house});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(10),
//       child: Column(
//         children: [
//           if (house.images.isNotEmpty)
//             Image.network(
//               house.images.first,
//               height: 150,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ListTile(
//             title: Text(house.title),
//             subtitle: Text('${house.city} - \$${house.price}'),
//           ),
//         ],
//       ),
//     );
//   }
// }