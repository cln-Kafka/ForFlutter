import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageService {
  Future<File> downloadImage(String imageUrl) async {
    try {
      // Download the image from the URL
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to download image: HTTP ${response.statusCode}',
        );
      }

      // Get temporary directory
      final tempDir = await getTemporaryDirectory();

      // Create a unique file name
      final fileName =
          'SharedImage_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = path.join(tempDir.path, fileName);

      // Write the image data to the file
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Failed to download image: $e');
    }
  }
}
