import 'package:flutter/material.dart';

import '../models/cat_image.dart';
import '../services/cat_api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CatApiService _catApiService = CatApiService();
  late Future<CatImage> _catImage;

  @override
  void initState() {
    super.initState();
    _loadCatImage();
  }

  void _loadCatImage() {
    setState(() {
      _catImage = _catApiService.fetchCatImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Котики из API')),
      body: FutureBuilder<CatImage>(
        future: _catImage,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: FilledButton.icon(
                onPressed: _loadCatImage,
                icon: const Icon(Icons.refresh),
                label: const Text('Повторить запрос'),
              ),
            );
          }

          final cat = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      cat.url,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Text('Не удалось загрузить фото')),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text('${cat.width} x ${cat.height}'),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: _loadCatImage,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Загрузить ещё'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
