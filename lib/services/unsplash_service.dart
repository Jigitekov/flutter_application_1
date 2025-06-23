import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo_model.dart';

class UnsplashService {
  static const String _baseUrl = 'https://api.unsplash.com';
  static const String _accessKey = '6SSa-VRQvOGHNNq73Fo8f8sBydZCHaFohKTgaF-4cd4'; 

  static Future<List<PhotoModel>> fetchRandomPhotos({int count = 8}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/photos/random?count=$count'),
      headers: {
        'Authorization': 'Client-ID $_accessKey',
      },
    );

    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body);
      return jsonData.map((json) => PhotoModel.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка загрузки изображений');
    }
  }

  static Future<List<PhotoModel>> searchPhotos(String query) async {
  final response = await http.get(
    Uri.parse('$_baseUrl/search/photos?query=$query&per_page=20'),
    headers: {
      'Authorization': 'Client-ID $_accessKey',
    },
  );

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List results = jsonData['results'];
    return results.map((json) => PhotoModel.fromJson(json)).toList();
  } else {
    throw Exception('Ошибка при поиске: ${response.statusCode}');
  }
}

}

