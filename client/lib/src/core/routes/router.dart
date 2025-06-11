import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_rental_flutter/src/features/manage_home/data/models/editable_property.dart';

import '../../features/add_property/presentation/pages/add_property_page.dart';
import '../../features/edit_property/presentation/pages/edit_property_page.dart';
import '../../features/manage_home/presentation/pages/manage_home_page.dart';
import '../../features/admin_dashboard/presentation/pages/admin_dashboard_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/signup/presentation/pages/signup_page.dart';
import '../../features/login/presentation/pages/login_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/favourite/presentation/pages/favourite_page.dart';

import '../../features/edit_property/domain/entities/new_property.dart';

// Riverpod integration with GoRouter
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
       GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminDashboardPage(),
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
