//lib/services/share_service.dart
/*import 'package:share_plus/share_plus.dart';


class ShareService {
  static void shareMessage(Message message) {
    Share.share(message.text);
  }
}*/
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import '../models/message.dart';
class ShareService {
  // Share text-only message
  Future<void> shareText(String content) async {
    await Share.share(content);
  }

  // Share text with an image
  Future<void> shareTextWithImage(String content, String imagePath) async {
    final file = File(imagePath);
    if (await file.exists()) {
      await Share.shareFiles([imagePath], text: content);
    } else {
      await Share.share(content);
    }
  }
}
