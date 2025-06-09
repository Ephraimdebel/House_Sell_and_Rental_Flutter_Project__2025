import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_rental_flutter/src/features/manage_home/data/models/editable_property.dart';

import '../../features/add_property/presentation/pages/add_property_page.dart';
import '../../features/edit_property/presentation/pages/edit_property_page.dart';
import '../../features/manage_home/presentation/pages/manage_home_page.dart';
import '../../features/edit_property/domain/entities/new_property.dart';

// Riverpod integration with GoRouter
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const ManageHomePage(),
      ),
      GoRoute(
        path: '/edit-property/:id',
        builder: (context, state) {
          final idString = state.pathParameters['id']!;
          final id = int.tryParse(idString) ?? 0;
          return EditPropertyPage(propertyId: id);
        },
      ),
    ],
  );
});
