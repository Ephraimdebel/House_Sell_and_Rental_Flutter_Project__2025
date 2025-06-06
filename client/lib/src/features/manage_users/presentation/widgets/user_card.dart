import 'package:flutter/material.dart';
import '../../domain/entities/entities.dart';

class UserCard extends StatelessWidget {
  final UserEntity user;
  final VoidCallback onDelete;

  const UserCard({required this.user, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 30),
        leading: CircleAvatar(child: Text(user.fullName[0])),
        title: Text(user.fullName, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email),
            Row(
              children: [
                Icon(Icons.phone, size: 16, color: Colors.blue),
                Text(user.phoneNumber),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: user.role == 'admin' ? const Color.fromARGB(255, 252, 221, 232) : const Color.fromARGB(255, 217, 238, 255),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                user.role == 'admin' ? 'Admin' : 'Guest',
                style:  TextStyle(color: user.role == 'admin' ? Colors.pink : Colors.blue),
              ),
            ),
          ],
        ),
       trailing: SizedBox(
        width: 96, // 2 buttons × 48 each
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: IconButton(
                icon: Icon(Icons.person_remove, color: Colors.red),
                onPressed: onDelete,
              ),
            ),
            SizedBox(width: 8), // Spacing between buttons
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: IconButton(
                icon: Icon(Icons.person, color: Colors.green),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),

      ),
    );
  }
}
