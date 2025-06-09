// manage_users_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/user_provider.dart';
import '../widgets/user_card.dart';

class ManageUsersPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ManageUsersPage> createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends ConsumerState<ManageUsersPage> {
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    final usersAsync = ref.watch(userListProvider);

    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text('Manage Users')
        ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (val) => setState(() => searchText = val.toLowerCase()),
            ),
          ),
          Expanded(
            child: usersAsync.when(
              data: (users) {
                final filtered = users.where((u) =>
                    u.fullName.toLowerCase().contains(searchText) ||
                    u.email.toLowerCase().contains(searchText)).toList();
                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final user = filtered[index];
                    return UserCard(
                      user: user,
                      onDelete: () async {
                        await ref.read(deleteUserProvider).call(user.id);
                        ref.invalidate(userListProvider);
                      },
                    );
                  },
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
