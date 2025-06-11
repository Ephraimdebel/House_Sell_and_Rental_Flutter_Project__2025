import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_rental_flutter/src/features/auth/presentation/providers/auth_provider.dart';
import '../../../admin_dashboard/presentation/pages/admin_dashboard_page.dart';
import '../../../login/presentation/pages/login_page.dart';
import '../../../signup/presentation/pages/signup_page.dart';

// Assume you have these providers from your auth logic

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(authNotifierProvider.select((state) => state.token));
    final user = ref.watch(authNotifierProvider.select((state) => state.user)); 
    // Assuming your authNotifierProvider state has a 'user' object with email, role, avatar

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
          ),

          const SizedBox(height: 24),

          // Settings section always shown
          _buildSection(
            title: 'Settings',
            items: [
              {'icon': Icons.language_outlined, 'title': 'Language'},
              {'icon': Icons.dark_mode_outlined, 'title': 'Dark Mode'},
              {'icon': Icons.help_outline, 'title': 'Help & Support'},
              {'icon': Icons.logout_outlined, 'title': 'Logout'},
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
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
                      builder: (context) => const LoginPage(),
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
                child: const Text("Sign Up", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
