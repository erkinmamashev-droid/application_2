import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/cat_image.dart';

class CatApiService {
  Future<CatImage> fetchCatImage() async {
    final response = await http.get(
      Uri.parse('https://api.thecatapi.com/v1/images/search'),
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка API: ${response.statusCode}');
    }

    final images = jsonDecode(response.body) as List<dynamic>;
    if (images.isEmpty) {
      throw Exception('API не вернул изображения');
    }

    return CatImage.fromJson(images.first as Map<String, dynamic>);
  }
}
