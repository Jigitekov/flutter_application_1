// import 'package:flutter/material.dart';

// class SearchScreen extends StatelessWidget {
//   const SearchScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Поиск')),
//       body: const Center(
//         child: Text('Экран поиска'),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/photo_provider.dart';
import '../widgets/photo_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  void _startSearch() {
    final query = _controller.text.trim();
    if (query.isNotEmpty) {
      Provider.of<PhotoProvider>(context, listen: false).searchPhotos(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PhotoProvider>(context);
    final results = provider.searchResults;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Поиск'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Введите ключевое слово',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _startSearch,
                ),
              ),
              onSubmitted: (_) => _startSearch(),
            ),
          ),
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : results.isEmpty
                    ? const Center(child: Text('Нет результатов'))
                    : ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) =>
                            PhotoCard(photo: results[index]),
                      ),
          ),
        ],
      ),
    );
  }
}
