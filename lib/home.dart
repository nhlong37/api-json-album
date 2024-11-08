import 'package:flutter/material.dart';
import '../api.dart';
import '../model/album.dart';
import 'album.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<Album> albums = [];

  @override
  void initState() {
    super.initState();
    fetchAlbums();
  }

  Future<void> fetchAlbums() async {
    try {
      //trả về danh sách dữ liệu của album từ file API Service
      final data = await apiService.fetchAlbums();
      setState(() {
        albums = data;
      });
    } catch (e) {
      print('Lỗi không thể tải danh sách album: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text(
          "Danh sách album".toUpperCase(),
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff272727)),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: albums.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 2.0),
              child: ListTile(
                leading: Icon(Icons.photo, color: Colors.blue, size: 40),
                title: Text(albums[index].title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff272727))),
                tileColor: Color(0xFFF4F4F4),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                trailing: Icon(Icons.arrow_forward, color: Color(0xff272727), size: 20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AlbumDetailScreen(albumId: albums[index].id),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
