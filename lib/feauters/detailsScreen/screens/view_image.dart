import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class ImageViewerScreen extends StatelessWidget {
  final String imageUrl;

  const ImageViewerScreen({super.key, required this.imageUrl});

  Future<void> downloadImage(String url) async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      var savePath = "${dir.path}/downloaded_image.jpg";

      await Dio().download(url, savePath);
      log('Image downloaded to $savePath');
    } catch (e) {
      log('Error downloading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Viewer'),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.download),
            onPressed: () => downloadImage(imageUrl),
          ),
        ],
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          enableRotation: true,
        ),
      ),
    );
  }
}
