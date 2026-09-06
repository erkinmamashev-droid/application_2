import '../models/cat_image.dart';

enum CatImageStatus { initial, loading, success, failure }

class CatImageState {
  const CatImageState({
    this.status = CatImageStatus.initial,
    this.catImage,
    this.errorMessage,
  });

  final CatImageStatus status;
  final CatImage? catImage;
  final String? errorMessage;

  CatImageState copyWith({
    CatImageStatus? status,
    CatImage? catImage,
    String? errorMessage,
  }) {
    return CatImageState(
      status: status ?? this.status,
      catImage: catImage ?? this.catImage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
