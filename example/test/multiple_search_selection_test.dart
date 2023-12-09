// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';

void main() {
  testWidgets('Finds MultipleSearchSelection widget',
      (WidgetTester tester) async {
    // Define test data
    List<String> items = ['Item 1', 'Item 2', 'Item 3'];

    // Build the test widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultipleSearchSelection<String>(
            searchField: const TextField(
              key: Key('searchField'),
            ),
            key: const Key('multipleSearchSelection'),
            items: items,
            pickedItemBuilder: (item) => Text(item),
            fieldToCheck: (item) => item,
            itemBuilder: (item, index) => Text(item),
          ),
        ),
      ),
    );

    // Find the MultipleSearchSelection widget
    expect(find.byKey(const Key('multipleSearchSelection')), findsOneWidget);
  });

  testWidgets('Displays correct items when searching',
      (WidgetTester tester) async {
    // Define test data
    List<String> items = ['Apple', 'Banana', 'Cherry'];

    // Build the test widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultipleSearchSelection<String>(
            searchField: const TextField(
              key: Key('searchField'),
            ),
            key: const Key('multipleSearchSelection'),
            items: items,
            pickedItemBuilder: (item) => Text(item),
            fieldToCheck: (item) => item,
            itemBuilder: (item, index) => Text(item),
          ),
        ),
      ),
    );

    // Tap on the search field to open the dropdown
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();

    // Type 'Ban' into the search field
    await tester.enterText(find.byType(TextField), 'Ban');
    await tester.pumpAndSettle();

    // Check if only the 'Banana' item is displayed
    expect(find.text('Apple'), findsNothing);
    expect(find.text('Banana'), findsOneWidget);
    expect(find.text('Cherry'), findsNothing);
  });
}
