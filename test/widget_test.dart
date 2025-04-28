// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/main.dart'; // Replace with your actual main app file

void main() {
  testWidgets('App loads and displays title', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify if the app title is displayed.
    expect(find.text('Offline Blog & Social Media'), findsOneWidget);
  });

  testWidgets('Adding a new message updates the UI', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Find the FloatingActionButton and tap it.
    final fab = find.byIcon(Icons.add);
    await tester.tap(fab);
    await tester.pumpAndSettle();

    // Enter text into the input field.
    final textField = find.byType(TextField);
    await tester.enterText(textField, 'Test Message');
    await tester.pump();

    // Tap the save button.
    final saveButton = find.text('Save');
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    // Verify that the new message appears in the list.
    expect(find.text('Test Message'), findsOneWidget);
  });

  testWidgets('Deleting a message removes it from the list', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Assume there is already a message present.
    final message = find.text('Test Message');
    expect(message, findsOneWidget);

    // Find and tap the delete button.
    final deleteButton = find.byIcon(Icons.delete);
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    // Verify the message is removed.
    expect(find.text('Test Message'), findsNothing);
  });
}
