//lib/screens/message_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/message.dart';
import '../helpers/database_helper.dart';
import '../services/share_service.dart';

class MessageDetailScreen extends StatelessWidget {
  final Message message;

  const MessageDetailScreen({super.key, required this.message});

  void _deleteMessage(BuildContext context) async {
    await DatabaseHelper.deleteMessage(message.id!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Text: ${message.text}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ShareService.shareMessage(message);
              },
              child: Text('Share'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _deleteMessage(context),
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
