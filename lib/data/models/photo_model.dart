class Photo {
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({required this.albumId, required this.title, required this.url, required this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}
