class ApiUserModelP {
  final String id;
  final String author;
  final int width;
  final int height;
  final String downloadUrl;

  ApiUserModelP({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.downloadUrl,
  });
  factory ApiUserModelP.fromjson(Map<String, dynamic> json) {
    return ApiUserModelP(
      id: json['id'],
      author: json['author'],
      width: json['width'],
      height: json['height'],
      downloadUrl: json['download_url'],
    );
  }

  get length => [];

  getRange(int offset, int limit) {}
}