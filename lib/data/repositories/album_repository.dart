import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album_model.dart';
import '../models/photo_model.dart';

class AlbumRepository {
  final http.Client httpClient;

  AlbumRepository({required this.httpClient});

  Future<List<Album>> fetchAlbums() async {
    final response = await httpClient.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Album.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<List<Photo>> fetchPhotos() async {
    final response = await httpClient.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Photo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
