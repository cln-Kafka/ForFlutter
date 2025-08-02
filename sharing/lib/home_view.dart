import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String imageUrl = "https://picsum.photos/400/600?random=1";
  bool isDownloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sharing Example'), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Image.network(imageUrl, fit: BoxFit.cover),
                  Positioned(
                    child: IconButton(
                      onPressed: changeImage,
                      icon: Icon(Icons.refresh),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              _buildElevatedButton("Share only the image URL", () async {
                final textShareResult = await SharePlus.instance.share(
                  ShareParams(
                    text: 'Hey, what do you think of this image ($imageUrl)?!',
                  ),
                );
                if (!mounted) return;
                if (textShareResult.status != ShareResultStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Text Shared Successfully')),
                  );
                }
              }),
              _buildElevatedButton(
                isDownloading ? "Downloading..." : "Share image",
                isDownloading ? null : _shareImage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _shareImage() async {
    setState(() {
      isDownloading = true;
    });

    try {
      // Download the image from the URL
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Get temporary directory
        final tempDir = await getTemporaryDirectory();

        // Create a unique file name
        final fileName =
            'SharedImage_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final filePath = path.join(tempDir.path, fileName);

        // Write the image data to the file
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Share the file
        await SharePlus.instance.share(ShareParams(files: [XFile(filePath)]));

        // Delete the temp file/image (optional)
        await file.delete();
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error sharing image: $e')));
    } finally {
      isDownloading = false;
    }
  }

  void changeImage() {
    // Generate a new random image URL
    setState(() {
      // Generates a random number between 0 and 999
      int randomInt = Random().nextInt(1000);
      imageUrl = "https://picsum.photos/400/600?random=$randomInt";
    });
  }

  Widget _buildElevatedButton(String buttonText, void Function()? onPressed) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Text(buttonText),
          ),
        ),
      ],
    );
  }
}
