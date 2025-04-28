import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/message.dart';
import 'message_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Message> _allMessages = [];
  List<Message> _filteredMessages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  // Load messages from the database
  Future<void> _loadMessages() async {
    final messages = await DatabaseHelper.getAllMessages();
    setState(() {
      _allMessages = messages;
      _filteredMessages = messages;
    });
  }

  // Filter messages based on search query
  void _filterMessages(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredMessages = _allMessages;
      });
    } else {
      setState(() {
        _filteredMessages =
            _allMessages
                .where(
                  (message) =>
                      message.text.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Messages',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _filterMessages('');
                  },
                ),
                border: const OutlineInputBorder(),
              ),
              onChanged: _filterMessages,
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  _filteredMessages.isEmpty
                      ? const Center(child: Text('No messages found.'))
                      : ListView.builder(
                        itemCount: _filteredMessages.length,
                        itemBuilder: (context, index) {
                          final message = _filteredMessages[index];
                          return ListTile(
                            title: Text(message.text),
                            subtitle: Text(message.timestamp.toString()),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          MessageDetailScreen(message: message),
                                ),
                              );
                            },
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
