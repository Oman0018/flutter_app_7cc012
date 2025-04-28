// lib/widgets/message_form.dart
import 'package:flutter/material.dart';

class MessageForm extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;

  const MessageForm({super.key, required this.controller, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Enter your message",
            border: OutlineInputBorder(),
          ),
          maxLines: 5,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: onSave,
          child: const Text("Save"),
        ),
      ],
    );
  }
}