import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    int _selectedIndex() {
      if (location.startsWith('/home')) return 0;
      if (location.startsWith('/search')) return 1;
      if (location.startsWith('/add')) return 2;
      if (location.startsWith('/favorites')) return 3;
      if (location.startsWith('/profile')) return 4;
      return 0;
    }

    return Scaffold(
      body: child,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Color(0xFF5D9DF0),
        onPressed: () => context.go('/add'),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        notchMargin: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(context, icon: Icons.home_outlined, label: 'Home', path: '/home', selected: _selectedIndex() == 0),
            _navItem(context, icon: Icons.search, label: 'Search', path: '/search', selected: _selectedIndex() == 1),
            const SizedBox(width: 48), // space for FAB
            _navItem(context, icon: Icons.favorite_border_outlined, label: 'Favorites', path: '/favorites', selected: _selectedIndex() == 3),
            _navItem(context, icon: Icons.person_outline_outlined, label: 'Profile', path: '/profile', selected: _selectedIndex() == 4),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
  BuildContext context, {
  required IconData icon,
  required String label,
  required String path,
  required bool selected,
}) {
  return GestureDetector(
    onTap: () => context.go(path),
    child: SizedBox(
      height: 56, // fixes the overflow by limiting vertical space
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center, // center vertically
        children: [
          Icon(icon, color: selected ? Colors.blue : Colors.black),
          Text(
            label,
            style: TextStyle(color: selected ? Colors.blue : Colors.black, fontSize: 12),
          ),
        ],
      ),
    ),
  );
}
}
