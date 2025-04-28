import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Correct import: screen, not widget
import 'screens/search_screen.dart'; // For searching
import 'screens/create_message_screen.dart'; // For creating new messages

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blogging & Wiki App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // Modern Material 3 theme
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/searchScreen': (context) => const SearchScreen(),
        '/createMessageScreen': (context) => const CreateMessageScreen(),
      },
    );
  }
}
