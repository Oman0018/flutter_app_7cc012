//lib/screens/create_message_screen.dart
import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/message.dart';

class CreateMessageScreen extends StatefulWidget {
  final Message? message;

  const CreateMessageScreen({super.key, this.message});

  @override
  _CreateMessageScreenState createState() => _CreateMessageScreenState();
}

class _CreateMessageScreenState extends State<CreateMessageScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.message != null) {
      _textController.text = widget.message!.text;
    }
  }

  void _saveMessage() async {
    final message = Message(
      id: widget.message?.id,
      text: _textController.text,
      timestamp: DateTime.now(),
    );
    if (message.id == null) {
      // Create new message
      await DatabaseHelper.insertMessage(message);
    } else {
      // Update existing message (we would need an update method)
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.message == null ? 'Create Message' : 'Edit Message'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Message'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveMessage,
              child: Text(widget.message == null ? 'Save' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}