class CatImage {
  const CatImage({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  final String id;
  final String url;
  final int width;
  final int height;

  factory CatImage.fromJson(Map<String, dynamic> json) {
    return CatImage(
      id: json['id'] as String,
      url: json['url'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
    );
  }
}
