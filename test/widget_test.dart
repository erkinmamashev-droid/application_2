import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:application_2/models/cat_image.dart';
import 'package:application_2/screens/home_page.dart';
import 'package:application_2/services/cat_api_service.dart';

class FakeCatApiService extends CatApiService {
  @override
  Future<CatImage> fetchCatImage() async {
    return const CatImage(
      id: 'test',
      url: 'https://example.com/cat.jpg',
      width: 400,
      height: 300,
    );
  }
}

void main() {
  testWidgets('shows loading state while requesting a cat', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(apiService: FakeCatApiService()),
      ),
    );

    expect(find.text('Котики из API'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
