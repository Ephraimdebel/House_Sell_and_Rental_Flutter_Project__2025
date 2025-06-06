import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_rental_flutter/src/features/manage_users/presentation/pages/manage_users_page.dart';
import 'package:house_rental_flutter/src/features/profile/presentation/pages/profile_page.dart';
import 'src/features/manage_home/presentation/pages/manage_home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manage Properties',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ManageUsersPage(),
    );
  }
}
