import 'package:flutter/material.dart';

// Database Constants
class DBConstants {
  static const String dbName = "messages.db";
  static const String messageTable = "messages";
  static const String columnId = "id";
  static const String columnContent = "content";
  static const String columnImagePath = "imagePath";
  static const String columnTimestamp = "timestamp";
}

// API Keys (Replace with actual keys)
class APIKeys {
  static const String twitterApiKey = "YOUR_TWITTER_API_KEY";
  static const String twitterApiSecret = "YOUR_TWITTER_API_SECRET";
  static const String wordpressApiKey = "YOUR_WORDPRESS_API_KEY";
}

// App Theme Colors
class AppColors {
  static const Color primaryColor = Colors.blue;
  static const Color accentColor = Colors.orange;
  static const Color backgroundColor = Colors.white;
}

// UI Strings
class UIStrings {
  static const String appTitle = "Offline Blog & Social Media";
  static const String emptyMessageList = "No messages available. Start writing!";
  static const String deleteConfirmation = "Are you sure you want to delete this message?";
}

// General Constants
class AppConstants {
  static const String imagePlaceholder = "assets/images/placeholder.png";
  static const int maxMessageLength = 5000;
}

