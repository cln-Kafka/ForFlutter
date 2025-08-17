import 'dart:io';

import 'package:share_plus/share_plus.dart';

class ShareHelper {
  Future<void> shareText(String text) async {
    try {
      await SharePlus.instance.share(ShareParams(text: text));
    } catch (e) {
      throw Exception('Failed to share text: $e');
    }
  }

  Future<void> shareFile(File file) async {
    try {
      if (!await file.exists()) {
        throw Exception('File does not exist: ${file.path}');
      }
      await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
    } catch (e) {
      throw Exception('Failed to share file: $e');
    }
  }
}
