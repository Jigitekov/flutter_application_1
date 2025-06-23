// import 'package:flutter/material.dart';
// import '../models/photo_model.dart';
// import '../services/unsplash_service.dart';

// class PhotoProvider extends ChangeNotifier {
//   List<PhotoModel> _randomPhotos = [];
//   bool _isLoading = false;

//   List<PhotoModel> get randomPhotos => _randomPhotos;
//   bool get isLoading => _isLoading;

//   Future<void> loadRandomPhotos() async {
//     _isLoading = true;
//     notifyListeners();

//     _randomPhotos = await UnsplashService.fetchRandomPhotos();

//     _isLoading = false;
//     notifyListeners();
//   }
// }


import 'package:flutter/material.dart';
import '../models/photo_model.dart';
import '../services/unsplash_service.dart';

class PhotoProvider extends ChangeNotifier {
  List<PhotoModel> _randomPhotos = [];
  final List<PhotoModel> _favorites = [];
  List<PhotoModel> _searchResults = [];
  bool _isLoading = false;

  List<PhotoModel> get randomPhotos => _randomPhotos;
  List<PhotoModel> get favorites => _favorites;
  List<PhotoModel> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  Future<void> loadRandomPhotos() async {
    try {
      _randomPhotos = await UnsplashService.fetchRandomPhotos();
    } catch (e) {
      _randomPhotos = [];
    }
    notifyListeners();
  }

  void toggleFavorite(PhotoModel photo) {
    final exists = _favorites.any((p) => p.id == photo.id);
    if (exists) {
      _favorites.removeWhere((p) => p.id == photo.id);
    } else {
      _favorites.add(photo);
    }
    notifyListeners();
  }

  bool isFavorite(PhotoModel photo) {
    return _favorites.any((p) => p.id == photo.id);
  }

  Future<void> searchPhotos(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _searchResults = await UnsplashService.searchPhotos(query);
    } catch (e) {
      _searchResults = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
