import 'package:api_json/api.dart';
import 'package:api_json/model/photo.dart';
import 'package:flutter/material.dart';

class PhotoDetailScreen extends StatefulWidget {
  final int photoId;
  const PhotoDetailScreen({super.key, required this.photoId});
  
  @override
  _PhotoDetailScreenState createState() => _PhotoDetailScreenState();
}

class _PhotoDetailScreenState extends State<PhotoDetailScreen> {
  final ApiService apiService = ApiService();
  Photo? photo;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPhotoData(widget.photoId);
  }

  
  // Lấy thông tin của Photo theo ID
  Future<void> fetchPhotoData(int photoId) async {
    try {
      final photoData = await apiService.fetchPhotoDetail(photoId);
      setState(() {
        photo = photoData;
        isLoading = false;
      });
    } catch (e) {
      print('Lỗi không thể tải dữ liệu hình ảnh: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(photo?.title.toUpperCase() ?? 'Chi tiết hình ảnh'.toUpperCase(), style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff272727)))),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.network(
                        '${photo!.thumbnailUrl.replaceAll(RegExp(r'^https://via.placeholder.com/150/'), 'https://picsum.photos/seed/')}/150',
                        fit: BoxFit.fill),
                    SizedBox(height: 10),
                    Text(photo?.title ?? 'Không có tiêu đề hình ảnh', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff272727))),
                  ],
                ),
              ),
            ),
    );
  }
}

