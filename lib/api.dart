import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/album.dart';
import '../model/photo.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Lấy danh sách album
  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(Uri.parse('$baseUrl/albums'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Album.fromJson(json)).toList();
    } else {
      throw Exception('không thể tải danh sách album');
    }
  }

  // Lấy thông tin chi tiết của một album
  Future<Album> fetchAlbumDetail(int albumId) async {
    final response = await http.get(Uri.parse('$baseUrl/albums/$albumId'));
    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('không thể tải thông tin chi tiết của album');
    }
  }

  // Lấy danh sách hình ảnh trong một album
  Future<List<Photo>> fetchAlbumPhotos(int albumId) async {
    final response = await http.get(Uri.parse('$baseUrl/albums/$albumId/photos'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Không thể tải ảnh trong album');
    }
  }

  // Lấy chi tiết một hình ảnh
  Future<Photo> fetchPhotoDetail(int photoId) async {
    final response = await http.get(Uri.parse('$baseUrl/photos/$photoId'));
    if (response.statusCode == 200) {
      return Photo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Không thể tải thông tin chi tiết của ảnh trong album');
    }
  }
}
