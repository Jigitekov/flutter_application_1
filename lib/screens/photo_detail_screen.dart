// import 'package:flutter/material.dart';
// import '../models/photo_model.dart';

// class PhotoDetailScreen extends StatelessWidget {
//   const PhotoDetailScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final photo = ModalRoute.of(context)!.settings.arguments as PhotoModel;

//     return Scaffold(
//       appBar: AppBar(title: Text(photo.user)),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Image.network(photo.imageUrl),
//             const SizedBox(height: 12),
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Text(
//                 photo.description,
//                 style: const TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/photo_model.dart';
import '../providers/photo_provider.dart';

class PhotoDetailScreen extends StatelessWidget {
  const PhotoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final photo = ModalRoute.of(context)!.settings.arguments as PhotoModel;
    final provider = Provider.of<PhotoProvider>(context);
    final isFavorite = provider.isFavorite(photo);

    return Scaffold(
      appBar: AppBar(
        title: Text(photo.user),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () => provider.toggleFavorite(photo),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(photo.imageUrl),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                photo.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
