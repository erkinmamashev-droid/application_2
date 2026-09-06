import 'package:dio/dio.dart';

import '../models/cat_image.dart';

class CatApiService {
  CatApiService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<CatImage> fetchCatImage() async {
    final response = await _dio.get<List<dynamic>>(
      'https://api.thecatapi.com/v1/images/search',
    );

    final images = response.data ?? <dynamic>[];
    if (images.isEmpty) {
      throw Exception('API не вернул изображения');
    }

    return CatImage.fromJson(images.first as Map<String, dynamic>);
  }
}
