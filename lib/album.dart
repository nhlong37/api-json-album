import 'package:api_json/api.dart';
import 'package:api_json/detail.dart';
import 'package:flutter/material.dart';
import '../model/album.dart';
import '../model/photo.dart';

class AlbumDetailScreen extends StatefulWidget {
  final int albumId;
  const AlbumDetailScreen({super.key, required this.albumId});
  @override
  _AlbumDetailScreenState createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  final ApiService apiService = ApiService();
  Album? album;
  List<Photo> photos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAlbumData(widget.albumId);
  }

  //Lấy dữ liệu album theo albumId
  Future<void> fetchAlbumData(int albumId) async {
    try {
      final albumData = await apiService.fetchAlbumDetail(albumId);
      final photosData = await apiService.fetchAlbumPhotos(albumId);
      setState(() {
        album = albumData;
        photos = photosData;
        isLoading = false;
      });
    } catch (e) {
      print('Lỗi không thể tải dữ liệu album: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(album?.title.toUpperCase() ?? 'Loading...'.toUpperCase(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff272727)))),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PhotoDetailScreen(photoId: photos[index].id)));
                  },
                  child: GridTile(
                      child: Column(children: [
                    Image.network(
                      '${photos[index].thumbnailUrl.replaceAll(RegExp(r'^https://via.placeholder.com/150/'), 'https://picsum.photos/seed/')}/150',
                      fit: BoxFit.fill,
                    ),
                  ])),
                );
              },
            ),
    );
  }
}
