import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental_flutter/src/core/mainScreen/main_screen.dart';
import 'package:house_rental_flutter/src/features/add_property/presentation/pages/add_property_page.dart';
import 'package:house_rental_flutter/src/features/admin_dashboard/presentation/pages/admin_dashboard_page.dart';
import 'package:house_rental_flutter/src/features/edit_property/presentation/pages/edit_property_page.dart';
import 'package:house_rental_flutter/src/features/home/presentation/pages/home_page.dart';
import 'package:house_rental_flutter/src/features/login/presentation/pages/login_page.dart';
import 'package:house_rental_flutter/src/features/manage_home/presentation/pages/manage_home_page.dart';
import 'package:house_rental_flutter/src/features/profile/presentation/pages/profile_page.dart';
import 'package:house_rental_flutter/src/features/signup/presentation/pages/signup_page.dart';
import 'package:house_rental_flutter/src/features/favourite/presentation/pages/favourite_page.dart';
import 'package:house_rental_flutter/src/features/search/presentation/pages/search_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      /// ShellRoute for Bottom Navigation Tabs
      ShellRoute(
        builder: (context, state, child) {
          return MainScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) => const SearchPage(), // example for Search
          ),
          GoRoute(
            path: '/add',
            builder: (context, state) => const AddPropertyPage(),
          ),
          GoRoute(
            path: '/favorites',
            builder: (context, state) => const FavouritePage(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),

      /// Non-bottom-nav routes
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminDashboardPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
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
