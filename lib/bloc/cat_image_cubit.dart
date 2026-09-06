import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/cat_api_service.dart';
import 'cat_image_state.dart';

class CatImageCubit extends Cubit<CatImageState> {
  CatImageCubit({CatApiService? apiService})
      : _apiService = apiService ?? CatApiService(),
        super(const CatImageState()) {
    loadCatImage();
  }

  final CatApiService _apiService;

  Future<void> loadCatImage() async {
    emit(state.copyWith(status: CatImageStatus.loading));

    try {
      final catImage = await _apiService.fetchCatImage();
      emit(
        state.copyWith(
          status: CatImageStatus.success,
          catImage: catImage,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CatImageStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
