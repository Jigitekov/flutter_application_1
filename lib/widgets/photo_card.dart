// import 'package:flutter/material.dart';
// import '../models/photo_model.dart';

// class PhotoCard extends StatelessWidget {
//   final PhotoModel photo;

//   const PhotoCard({super.key, required this.photo});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(
//           context,
//           '/photoDetail',
//           arguments: photo,
//         );
//       },
//       child: Card(
//         margin: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             Image.network(photo.imageUrl),
//             ListTile(
//               title: Text(photo.user),
//               subtitle: Text(photo.description),
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

class PhotoCard extends StatelessWidget {
  final PhotoModel photo;

  const PhotoCard({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PhotoProvider>(context);
    final isFavorite = provider.isFavorite(photo);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/photoDetail', arguments: photo);
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.network(photo.imageUrl),
            ListTile(
              title: Text(photo.user),
              subtitle: Text(photo.description),
              trailing: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () => provider.toggleFavorite(photo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
