import 'package:flutter/material.dart';
import '../../domain/entities/entities.dart';

class UserCard extends StatelessWidget {
  final UserEntity user;
  final VoidCallback onDelete;

  const UserCard({required this.user, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(child: Text(user.fullName[0])),
        title: Text(user.fullName, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email),
            Text(user.phoneNumber),
            Chip(label: Text(user.role)),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
