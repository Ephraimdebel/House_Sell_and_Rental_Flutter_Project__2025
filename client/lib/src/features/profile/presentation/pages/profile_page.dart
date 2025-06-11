<<<<<<< HEAD
import 'package:house_rental_flutter/src/features/login/application/secure_storage_provider.dart';
import 'package:house_rental_flutter/src/features/admin_dashboard/presentation/pages/admin_dashboard_page.dart';
import 'package:house_rental_flutter/src/features/signup/presentation/pages/signup_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_rental_flutter/src/core/models/auth_user.dart';
import 'package:house_rental_flutter/src/features/auth/presentation/providers/auth_provider.dart';
=======
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_rental_flutter/src/features/auth/presentation/providers/auth_provider.dart';
import '../../../admin_dashboard/presentation/pages/admin_dashboard_page.dart';
import '../../../login/presentation/pages/login_page.dart';
import '../../../signup/presentation/pages/signup_page.dart';

// Assume you have these providers from your auth logic
>>>>>>> f91c9fe42f0d87503c048d4dc8fb42f5a5678f9c

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
<<<<<<< HEAD
    final userAsync = ref.watch(currentUserProvider);
=======
    final token = ref.watch(authNotifierProvider.select((state) => state.token));
    final user = ref.watch(authNotifierProvider.select((state) => state.user)); 
    // Assuming your authNotifierProvider state has a 'user' object with email, role, avatar
>>>>>>> f91c9fe42f0d87503c048d4dc8fb42f5a5678f9c

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.blue),
        ),
        elevation: 0.5,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('My Profile',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

<<<<<<< HEAD
          // ✅ User Card or Welcome Card
          userAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => const Text('Error loading user'),
            data: (user) {
              if (user == null) {
                // 🔹 Guest Card
                return _buildGuestCard(context);
              } else {
                // 🔹 Logged-in User Card
                return _buildUserCard(user);
              }
            },
          ),

          const SizedBox(height: 32),

          // 🔹 Account Section
          Container(
            margin: const EdgeInsets.only(top: 24),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Account',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ..._buildMenuItems([
                  {'icon': Icons.person_outline, 'title': 'Personal Information'},
                  {'icon': Icons.home_outlined, 'title': 'My Properties'},
                  {'icon': Icons.favorite_border, 'title': 'Favorites'},
                  {'icon': Icons.notifications_none, 'title': 'Notifications'},
                ]),
              ],
            ),
=======
          // If no token, show welcome card
          if (token == null || token.isEmpty) 
            _buildWelcomeCard(context)
          else
            _buildUserInfo(context, user),

          const SizedBox(height: 32),

          // Account section always shown
          _buildSection(
            title: 'Account',
            items: [
              {'icon': Icons.person_outline, 'title': 'Personal Information'},
              {'icon': Icons.home_outlined, 'title': 'My Properties'},
              {'icon': Icons.favorite_border, 'title': 'Favorites'},
              {'icon': Icons.notifications_none, 'title': 'Notifications'},
            ],
>>>>>>> f91c9fe42f0d87503c048d4dc8fb42f5a5678f9c
          ),

          const SizedBox(height: 24),

<<<<<<< HEAD
          // 🔹 Settings Section
          Container(
            margin: const EdgeInsets.only(top: 24),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Settings',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ..._buildMenuItems([
                  {'icon': Icons.language_outlined, 'title': 'Language'},
                  {'icon': Icons.dark_mode_outlined, 'title': 'Dark Mode'},
                  {'icon': Icons.help_outline, 'title': 'Help & Support'},
                  {'icon': Icons.logout_outlined, 'title': 'Logout'},
                ]),
              ],
            ),
=======
          // Settings section always shown
          _buildSection(
            title: 'Settings',
            items: [
              {'icon': Icons.language_outlined, 'title': 'Language'},
              {'icon': Icons.dark_mode_outlined, 'title': 'Dark Mode'},
              {'icon': Icons.help_outline, 'title': 'Help & Support'},
              {'icon': Icons.logout_outlined, 'title': 'Logout'},
            ],
>>>>>>> f91c9fe42f0d87503c048d4dc8fb42f5a5678f9c
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  // 🔹 Guest Card (default card)
  Widget _buildGuestCard(BuildContext context) {
=======
  Widget _buildWelcomeCard(BuildContext context) {
>>>>>>> f91c9fe42f0d87503c048d4dc8fb42f5a5678f9c
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          const Text(
            "Welcome",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Sign in to manage your properties\nand favorites",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
<<<<<<< HEAD
                      builder: (context) => const AdminDashboardPage(),
=======
                      builder: (context) => const LoginPage(),
>>>>>>> f91c9fe42f0d87503c048d4dc8fb42f5a5678f9c
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text("Login"),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  side: const BorderSide(color: Colors.blue),
                ),
<<<<<<< HEAD
                child: const Text("Sign Up",
                    style: TextStyle(color: Colors.blue)),
=======
                child: const Text("Sign Up", style: TextStyle(color: Colors.blue)),
>>>>>>> f91c9fe42f0d87503c048d4dc8fb42f5a5678f9c
              ),
            ],
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  // 🔹 Logged-in User Card
  Widget _buildUserCard(AuthUser user) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(user.name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(user.email, style: const TextStyle(color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }

  // 🔹 Menu Section Builder
=======
  Widget _buildUserInfo(BuildContext context, dynamic user) {
    // If user is null for some reason, fallback to something
    if (user == null) {
      return const SizedBox.shrink();
    }

    final role = user.role ?? '';
    final email = user.email ?? '';
    final avatarUrl = user.avatarUrl ??
        'https://i.pravatar.cc/150?img=3'; // fallback avatar url

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(avatarUrl),
          ),
          const SizedBox(height: 16),
          Text(
            email,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Role: $role',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),

          if (role.toLowerCase() == 'admin')
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AdminDashboardPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('Admin Dashboard'),
            ),
        ],
      ),
    );
  }

  Widget _buildSection(
      {required String title, required List<Map<String, dynamic>> items}) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ..._buildMenuItems(items),
        ],
      ),
    );
  }

>>>>>>> f91c9fe42f0d87503c048d4dc8fb42f5a5678f9c
  List<Widget> _buildMenuItems(List<Map<String, dynamic>> items) {
    return items.map((item) {
      return Column(
        children: [
          ListTile(
            leading: Icon(item['icon'], color: Colors.blue),
            title: Text(item['title']),
            onTap: () {
              // TODO: Add navigation or action here
            },
          ),
          const Divider(height: 0),
        ],
      );
    }).toList();
  }
}
