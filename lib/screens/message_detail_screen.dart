// lib/screens/message_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/message.dart';
import '../helpers/database_helper.dart';
import '../services/share_service.dart';
import 'home_screen.dart'; // ✅ Added import for HomeScreen

class MessageDetailScreen extends StatelessWidget {
  final Message message;

  const MessageDetailScreen({super.key, required this.message});

  void _deleteMessage(BuildContext context) async {
    await DatabaseHelper.deleteMessage(message.id!);
    Navigator.pop(context);
  }

  void _returnHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => _returnHome(context), // ✅ Home button added
            tooltip: 'Return to Home',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Text: ${message.text}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ShareService.shareMessage(message);
              },
              child: const Text('Share'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _deleteMessage(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
