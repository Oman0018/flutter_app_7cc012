import 'package:flutter/material.dart';
import 'widgets/home_screen_widgets.dart'; // Import your custom HomeScreen (or MessageListScreen)

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blogging App', // Change the title of your app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // Use Material 3 theme
      ),
      home: const HomeScreen(), // Replace MyHomePage with your custom screen
    );
  }
}
