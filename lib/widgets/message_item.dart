// lib/widgets/message_item.dart
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/message.dart'; // Make sure you have a Message model

class MessageItem extends StatelessWidget {
  final Message message;
  final VoidCallback onDelete;

  const MessageItem({super.key, required this.message, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        leading:
            message.imagePath != null && message.imagePath!.isNotEmpty
                ? Image.file(
                  File(message.imagePath!),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                : const Icon(Icons.image_not_supported),
        title: Text(message.text),
        subtitle: Text(message.timestamp.toString()),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
