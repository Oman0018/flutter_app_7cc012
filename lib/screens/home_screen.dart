import 'package:flutter/material.dart';
import '../helpers/database_helper.dart'; // Ensure correct imports
import 'message_detail_screen.dart'; // Detail screen for viewing messages
import 'create_message_screen.dart'; // Screen for creating new messages
import '../widgets/home_screen_button.dart'; // Import your reusable button widget

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
          // Add HomeScreenButton for an extra action (e.g., search or settings)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: HomeScreenButton(
              label: 'Go to Search Screen',
              onPressed: () {
                Navigator.pushNamed(context, '/searchScreen'); // Example action
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
                    final message = snapshot.data![index];
                    return ListTile(
                      title: Text(message['title']),
                      subtitle: Text(message['content']),
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
            MaterialPageRoute(builder: (context) => CreateMessageScreen()),
          ).then((_) => _refreshMessages());
        },
      ),
    );
  }
}
