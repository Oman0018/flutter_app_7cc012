// lib/widgets/message_item.dart
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final String content;
  final VoidCallback onDelete;

  const MessageItem({super.key, required this.content, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        title: Text(content),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
