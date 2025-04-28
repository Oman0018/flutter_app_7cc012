import 'package:flutter/material.dart';
import '../db_helper.dart';
import '../models/message_model.dart';

class AddEditMessageScreen extends StatefulWidget {
  final Message? message; // If null, this is for adding a new message.

  const AddEditMessageScreen({super.key, this.message});

  @override
  _AddEditMessageScreenState createState() => _AddEditMessageScreenState();
}

class _AddEditMessageScreenState extends State<AddEditMessageScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.message != null) {
      // Prefill fields for editing
      _titleController.text = widget.message!.title;
      _contentController.text = widget.message!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveMessage() async {
    if (_formKey.currentState!.validate()) {
      final message = Message(
        id: widget.message?.id, // Keep the ID for edits, null for new
        title: _titleController.text,
        content: _contentController.text,
        imagePath: null, // We'll add image handling later
        timestamp: DateTime.now().toIso8601String(),
      );

      if (widget.message == null) {
        // Add new message
        await DatabaseHelper.instance.createMessage(message.toMap());
      } else {
        // Update existing message
        await DatabaseHelper.instance.updateMessage(message.toMap());
      }

      Navigator.pop(context, true); // Return to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.message == null ? 'Add Message' : 'Edit Message'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a title'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 5,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter content'
                    : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveMessage,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}