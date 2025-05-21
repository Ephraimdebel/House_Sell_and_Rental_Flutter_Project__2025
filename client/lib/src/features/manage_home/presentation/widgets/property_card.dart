// import 'package:flutter/material.dart';
// import '../../domain/entities/property.dart';

// class PropertyCard extends StatelessWidget {
//   final Property property;

//   const PropertyCard({required this.property, super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Replace localhost with 10.0.2.2 for emulator compatibility
//     final fixedImageUrl = property.imageUrl.replaceFirst('localhost', '10.0.2.2');

//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: ListTile(
//         leading: Image.network(
//           fixedImageUrl,
//           width: 60,
//           height: 60,
//           fit: BoxFit.cover,
//           errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
//         ),
//         title: Text(property.title, overflow: TextOverflow.ellipsis),
//         subtitle: Text('${property.city}, ${property.country}'),
//         trailing: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(property.type, style: TextStyle(color: Colors.blueGrey)),
//             Text('ETB ${property.price}', style: TextStyle(color: Colors.blue)),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../domain/entities/property.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PropertyCard({
    super.key,
    required this.property,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = property.imageUrl.replaceFirst('localhost', '10.0.2.2');
    final isForSale = property.type.toLowerCase() == 'for sale';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        property.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${property.city}, ${property.country}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isForSale
                            ? Colors.red.shade100
                            : Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        property.type,
                        style: TextStyle(
                          color: isForSale ? Colors.red : Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      isForSale
                          ? 'ETB ${property.price}'
                          : 'ETB ${property.price}/mo',
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
     Column(
  children: [
    // ⭐ Star Icon with smaller background
    Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.withOpacity(0.2),
      ),
      child: const Center(
        child: Icon(Icons.star, color: Colors.amber, size: 18),
      ),
    ),
    const SizedBox(height: 6),

    // ✏️ Edit icon with smaller background
    GestureDetector(
      onTap: onEdit,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.2),
        ),
        child: const Center(
          child: Icon(Icons.edit, color: Colors.blue, size: 18),
        ),
      ),
    ),
    const SizedBox(height: 6),

    // 🗑️ Delete icon with smaller background
    GestureDetector(
      onTap: onDelete,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.2),
        ),
        child: const Center(
          child: Icon(Icons.delete, color: Colors.red, size: 18),
        ),
      ),
    ),
  ],
)


  

        ],
      ),
    );
  }
}
