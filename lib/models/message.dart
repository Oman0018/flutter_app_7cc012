//lib/models/message.dart
class Message {
  final int? id;
  final String text;
  final String? imagePath;
  final DateTime timestamp;

  Message({
    this.id,
    required this.text,
    this.imagePath,
    required this.timestamp,
  });

  // Convert a Message object to a map for storing in the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'imagePath': imagePath,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Create a Message object from a map (retrieved from the database)
  static Message fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      text: map['text'],
      imagePath: map['imagePath'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
