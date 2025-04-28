import 'package:flutter/material.dart';
import '../helpers/database_helper.dart'; // Database operations
import '../models/message.dart'; // Message model
import 'message_detail_screen.dart'; // Detail screen for viewing messages
import 'create_message_screen.dart'; // Screen for creating new messages
import '../widgets/home_screen_button.dart'; // Custom reusable button

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Map<String, dynamic>>> messages;

  @override
  void initState() {
    super.initState();
    _refreshMessages();
  }

  void _refreshMessages() {
    setState(() {
      messages = DatabaseHelper.instance.readAllMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: Column(
        children: [
          // Reusable button for an extra action (e.g., Search)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: HomeScreenButton(
              label: 'Go to Search Screen',
              onPressed: () {
                Navigator.pushNamed(context, '/searchScreen');
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: messages,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('No messages found.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final messageMap = snapshot.data![index];

                    // Convert the database Map to a Message object
                    final message = Message(
                      id: messageMap['id'],
                      text:
                          messageMap['text'], // <-- Match your DB column names
                      imagePath: messageMap['imagePath'],
                      timestamp: DateTime.parse(messageMap['timestamp']),
                    );

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
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateMessageScreen(),
            ),
          ).then(
            (_) => _refreshMessages(),
          ); // Refresh after new message created
        },
      ),
    );
  }
}
