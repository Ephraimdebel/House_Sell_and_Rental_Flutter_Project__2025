import 'package:flutter/material.dart';

class ManageButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ManageButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
    child:GestureDetector(
      onTap: onTap,
      child: Container(
        height: 130.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 24, child: Icon(icon, size: 24)),
            SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    ),
    );
  }
}
