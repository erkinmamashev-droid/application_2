import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cat_image_cubit.dart';
import '../bloc/cat_image_state.dart';
import '../models/cat_image.dart';
import '../services/cat_api_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.apiService});

  final CatApiService? apiService;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CatImageCubit(apiService: apiService),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Котики из API')),
      body: BlocBuilder<CatImageCubit, CatImageState>(
        builder: (context, state) {
          switch (state.status) {
            case CatImageStatus.initial:
            case CatImageStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case CatImageStatus.failure:
              return _ErrorView(
                message: state.errorMessage ?? 'Неизвестная ошибка',
              );
            case CatImageStatus.success:
              return _CatView(cat: state.catImage!);
          }
        },
      ),
    );
  }
}

class _CatView extends StatelessWidget {
  const _CatView({required this.cat});

  final CatImage cat;

  @override
  Widget build(BuildContext context) {
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
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text('Не удалось загрузить фото'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('${cat.width} x ${cat.height}'),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () => context.read<CatImageCubit>().loadCatImage(),
            icon: const Icon(Icons.refresh),
            label: const Text('Загрузить ещё'),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () => context.read<CatImageCubit>().loadCatImage(),
            icon: const Icon(Icons.refresh),
            label: const Text('Повторить запрос'),
          ),
        ],
      ),
    );
  }
}
