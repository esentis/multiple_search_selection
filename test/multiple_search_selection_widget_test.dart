import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';

Finder _item(String item) => find.text('item:$item');
Finder _pickedItem(String item) => find.text('picked:$item');
Finder _createItem(String item) => find.text('create:$item');

Widget _buildSelectionApp({
  required TextField searchField,
  required List<String> items,
  ShowedItemsVisibility itemsVisibility = ShowedItemsVisibility.alwaysOn,
  OverlayOptions<String>? overlayOptions,
  CreateOptions<String>? createOptions,
  MultipleSearchController<String>? controller,
  List<String>? initialPickedItems,
  int? maxSelectedItems,
  bool overlay = false,
}) {
  final Widget selection;

  if (overlay) {
    selection = MultipleSearchSelection<String>.overlay(
      key: const Key('selection'),
      searchField: searchField,
      items: items,
      itemsVisibility: itemsVisibility,
      overlayOptions: overlayOptions,
      controller: controller,
      initialPickedItems: initialPickedItems,
      maxSelectedItems: maxSelectedItems,
      pickedItemBuilder: (item) => Text('picked:$item'),
      fieldToCheck: (item) => item,
      itemBuilder: (item, index, isPicked) => Text('item:$item'),
    );
  } else if (createOptions != null) {
    selection = MultipleSearchSelection<String>.creatable(
      key: const Key('selection'),
      searchField: searchField,
      items: items,
      itemsVisibility: itemsVisibility,
      createOptions: createOptions,
      controller: controller,
      initialPickedItems: initialPickedItems,
      maxSelectedItems: maxSelectedItems,
      pickedItemBuilder: (item) => Text('picked:$item'),
      fieldToCheck: (item) => item,
      itemBuilder: (item, index, isPicked) => Text('item:$item'),
    );
  } else {
    selection = MultipleSearchSelection<String>(
      key: const Key('selection'),
      searchField: searchField,
      items: items,
      itemsVisibility: itemsVisibility,
      controller: controller,
      initialPickedItems: initialPickedItems,
      maxSelectedItems: maxSelectedItems,
      pickedItemBuilder: (item) => Text('picked:$item'),
      fieldToCheck: (item) => item,
      itemBuilder: (item, index, isPicked) => Text('item:$item'),
    );
  }

  return MaterialApp(
    home: Scaffold(
      body: selection,
    ),
  );
}

Future<void> _enterSearchText(WidgetTester tester, String text) async {
  await tester.enterText(find.byType(TextField).first, text);
  await tester.pumpAndSettle();
}

Future<void> _tapItem(
  WidgetTester tester,
  String item, {
  int index = 0,
}) async {
  await tester.tap(
    find
        .ancestor(
          of: _item(item).at(index),
          matching: find.byType(GestureDetector),
        )
        .first,
  );
  await tester.pumpAndSettle();
}

Future<void> _tapCreateAction(WidgetTester tester, String item) async {
  await tester.tap(
    find
        .ancestor(
          of: _createItem(item),
          matching: find.byType(GestureDetector),
        )
        .first,
  );
  await tester.pumpAndSettle();
}

void main() {
  group('Search State', () {
    testWidgets('keeps onType search results visible when items update',
        (WidgetTester tester) async {
      final controller = TextEditingController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(controller: controller),
          items: const ['Apple', 'Banana'],
          itemsVisibility: ShowedItemsVisibility.onType,
        ),
      );

      await _enterSearchText(tester, 'Ban');

      expect(_item('Banana'), findsOneWidget);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(controller: controller),
          items: const ['Apple', 'Banana', 'Band'],
          itemsVisibility: ShowedItemsVisibility.onType,
        ),
      );
      await tester.pumpAndSettle();

      expect(_item('Apple'), findsNothing);
      expect(_item('Banana'), findsOneWidget);
      expect(_item('Band'), findsOneWidget);
    });

    testWidgets('swapping search controllers keeps onType results visible',
        (WidgetTester tester) async {
      final emptyController = TextEditingController();
      final searchController = TextEditingController(text: 'Ban');
      addTearDown(emptyController.dispose);
      addTearDown(searchController.dispose);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(controller: emptyController),
          items: const ['Apple', 'Banana', 'Cherry'],
          itemsVisibility: ShowedItemsVisibility.onType,
        ),
      );

      expect(_item('Banana'), findsNothing);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(controller: searchController),
          items: const ['Apple', 'Banana', 'Cherry'],
          itemsVisibility: ShowedItemsVisibility.onType,
        ),
      );
      await tester.pumpAndSettle();

      expect(_item('Apple'), findsNothing);
      expect(_item('Banana'), findsOneWidget);
      expect(_item('Cherry'), findsNothing);
    });

    testWidgets('respects minCharsToShowItems in onType mode',
        (WidgetTester tester) async {
      final controller = MultipleSearchController<String>(
        minCharsToShowItems: 3,
      );

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: const TextField(),
          items: const ['Apple', 'Banana'],
          itemsVisibility: ShowedItemsVisibility.onType,
          controller: controller,
        ),
      );

      await _enterSearchText(tester, 'Ba');
      expect(_item('Banana'), findsNothing);

      await _enterSearchText(tester, 'Ban');
      expect(_item('Banana'), findsOneWidget);
    });

    testWidgets('clearSearchField hides onType results again',
        (WidgetTester tester) async {
      final controller = MultipleSearchController<String>();

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: const TextField(),
          items: const ['Apple', 'Banana'],
          itemsVisibility: ShowedItemsVisibility.onType,
          controller: controller,
        ),
      );

      await _enterSearchText(tester, 'Ban');
      expect(_item('Banana'), findsOneWidget);

      controller.clearSearchField();
      await tester.pumpAndSettle();

      expect(_item('Banana'), findsNothing);
    });

    testWidgets('initialPickedItems updates keep active onType search in sync',
        (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Ban');
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(controller: controller),
          items: const ['Apple', 'Banana', 'Band'],
          initialPickedItems: const ['Apple'],
          itemsVisibility: ShowedItemsVisibility.onType,
        ),
      );
      await tester.pumpAndSettle();

      expect(_item('Banana'), findsOneWidget);
      expect(_item('Band'), findsOneWidget);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(controller: controller),
          items: const ['Apple', 'Banana', 'Band'],
          initialPickedItems: const ['Apple', 'Banana'],
          itemsVisibility: ShowedItemsVisibility.onType,
        ),
      );
      await tester.pumpAndSettle();

      expect(_item('Apple'), findsNothing);
      expect(_item('Banana'), findsNothing);
      expect(_item('Band'), findsOneWidget);
      expect(_pickedItem('Banana'), findsOneWidget);
    });
  });

  group('Controller And Selection', () {
    testWidgets('controller lists are unmodifiable',
        (WidgetTester tester) async {
      final controller = MultipleSearchController<String>();

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: const TextField(),
          items: const ['Apple', 'Banana'],
          controller: controller,
        ),
      );

      await _tapItem(tester, 'Apple');

      expect(controller.getPickedItems(), ['Apple']);
      expect(
        () => controller.getAllItems().add('Pear'),
        throwsUnsupportedError,
      );
      expect(
        () => controller.getPickedItems().add('Pear'),
        throwsUnsupportedError,
      );
    });

    testWidgets('selectAllItems respects maxSelectedItems',
        (WidgetTester tester) async {
      final controller = MultipleSearchController<String>();

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: const TextField(),
          items: const ['Apple', 'Banana', 'Cherry'],
          controller: controller,
          maxSelectedItems: 2,
        ),
      );

      controller.selectAllItems();
      await tester.pumpAndSettle();

      expect(controller.getPickedItems(), ['Apple', 'Banana']);
      expect(_pickedItem('Apple'), findsOneWidget);
      expect(_pickedItem('Banana'), findsOneWidget);
      expect(_pickedItem('Cherry'), findsNothing);
    });

    testWidgets('selectAllItems keeps alwaysOn selectable items visible',
        (WidgetTester tester) async {
      final controller = MultipleSearchController<String>(isSelectable: true);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: const TextField(),
          items: const ['Apple', 'Banana', 'Cherry'],
          controller: controller,
        ),
      );

      controller.selectAllItems();
      await tester.pumpAndSettle();

      expect(controller.getPickedItems(), ['Apple', 'Banana', 'Cherry']);
      expect(_item('Apple'), findsOneWidget);
      expect(_item('Banana'), findsOneWidget);
      expect(_item('Cherry'), findsOneWidget);
    });

    testWidgets('clearAllPickedItems does not duplicate selectable items',
        (WidgetTester tester) async {
      final controller = MultipleSearchController<String>(isSelectable: true);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: const TextField(),
          items: const ['Apple', 'Banana'],
          controller: controller,
        ),
      );

      await _tapItem(tester, 'Apple');

      expect(controller.getPickedItems(), ['Apple']);
      expect(
        controller.getAllItems().where((item) => item == 'Apple').length,
        1,
      );

      controller.clearAllPickedItems();
      await tester.pumpAndSettle();

      expect(controller.getPickedItems(), isEmpty);
      expect(
        controller.getAllItems().where((item) => item == 'Apple').length,
        1,
      );
    });

    testWidgets('disallows duplicate selection when duplicate items exist',
        (WidgetTester tester) async {
      final controller = MultipleSearchController<String>(
        allowDuplicateSelection: false,
      );

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: const TextField(),
          items: const ['Apple', 'Apple', 'Banana'],
          controller: controller,
        ),
      );

      expect(_item('Apple'), findsNWidgets(2));

      await _tapItem(tester, 'Apple');
      await _tapItem(tester, 'Apple');

      expect(controller.getPickedItems(), ['Apple']);
      expect(_pickedItem('Apple'), findsOneWidget);
    });

    testWidgets('controller swaps detach old callbacks and bind the new ones',
        (WidgetTester tester) async {
      final firstController = MultipleSearchController<String>();
      final secondController = MultipleSearchController<String>();

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: const TextField(),
          items: const ['Apple', 'Banana'],
          controller: firstController,
        ),
      );

      firstController.selectAllItems();
      await tester.pumpAndSettle();
      expect(firstController.getPickedItems(), ['Apple', 'Banana']);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: const TextField(),
          items: const ['Apple', 'Banana'],
          controller: secondController,
        ),
      );
      await tester.pumpAndSettle();

      firstController.clearAllPickedItems();
      await tester.pumpAndSettle();
      expect(secondController.getPickedItems(), ['Apple', 'Banana']);

      firstController.selectAllItems();
      await tester.pumpAndSettle();
      expect(firstController.getPickedItems(), isEmpty);

      secondController.clearAllPickedItems();
      await tester.pumpAndSettle();
      expect(secondController.getPickedItems(), isEmpty);

      secondController.selectAllItems();
      await tester.pumpAndSettle();
      expect(secondController.getPickedItems(), ['Apple', 'Banana']);
    });

    testWidgets('controller searchItems reflects updated widget items',
        (WidgetTester tester) async {
      final controller = MultipleSearchController<String>();

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: const TextField(),
          items: const ['Apple', 'Banana'],
          controller: controller,
        ),
      );

      expect(controller.searchItems('Ban'), ['Banana']);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: const TextField(),
          items: const ['Apple', 'Banana', 'Band'],
          controller: controller,
        ),
      );
      await tester.pumpAndSettle();

      expect(controller.searchItems('Ban'), ['Banana', 'Band']);
    });
  });

  group('Creatable', () {
    testWidgets('validator can block creating an item',
        (WidgetTester tester) async {
      var onCreatedCalls = 0;

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: const TextField(),
          items: const ['Apple'],
          itemsVisibility: ShowedItemsVisibility.onType,
          createOptions: CreateOptions<String>(
            create: (text) => text,
            createBuilder: (text) => Text('create:$text'),
            validator: (_) => false,
            onCreated: (_) => onCreatedCalls++,
          ),
        ),
      );

      await _enterSearchText(tester, 'Pear');
      expect(_createItem('Pear'), findsOneWidget);

      await _tapCreateAction(tester, 'Pear');

      expect(onCreatedCalls, 0);
      expect(_item('Pear'), findsNothing);
      expect(_createItem('Pear'), findsOneWidget);
    });

    testWidgets('creates unpicked items and calls onCreated',
        (WidgetTester tester) async {
      final createdItems = <String>[];

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: const TextField(),
          items: const ['Apple'],
          itemsVisibility: ShowedItemsVisibility.onType,
          createOptions: CreateOptions<String>(
            create: (text) => text,
            createBuilder: (text) => Text('create:$text'),
            onCreated: createdItems.add,
          ),
        ),
      );

      await _enterSearchText(tester, 'Pear');
      await _tapCreateAction(tester, 'Pear');

      expect(createdItems, ['Pear']);
      expect(_item('Pear'), findsOneWidget);
      expect(_pickedItem('Pear'), findsNothing);
    });

    testWidgets('overlay create flow can add unpicked items',
        (WidgetTester tester) async {
      final controller = TextEditingController();
      final createdItems = <String>[];
      final overlayOptions = OverlayOptions<String>(
        canCreateItem: true,
        createOptions: CreateOptions<String>(
          create: (text) => text,
          createBuilder: (text) => Text('create:$text'),
          onCreated: createdItems.add,
        ),
      );
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(controller: controller),
          items: const ['Apple'],
          itemsVisibility: ShowedItemsVisibility.onType,
          overlay: true,
          overlayOptions: overlayOptions,
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await _enterSearchText(tester, 'Pear');
      expect(_createItem('Pear'), findsOneWidget);

      await _tapCreateAction(tester, 'Pear');

      expect(createdItems, ['Pear']);
      expect(_item('Pear'), findsOneWidget);
      expect(_pickedItem('Pear'), findsNothing);
    });

    testWidgets('overlay validator can block creating an item',
        (WidgetTester tester) async {
      final controller = TextEditingController();
      var onCreatedCalls = 0;
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(controller: controller),
          items: const ['Apple'],
          itemsVisibility: ShowedItemsVisibility.onType,
          overlay: true,
          overlayOptions: OverlayOptions<String>(
            canCreateItem: true,
            createOptions: CreateOptions<String>(
              create: (text) => text,
              createBuilder: (text) => Text('create:$text'),
              validator: (_) => false,
              onCreated: (_) => onCreatedCalls++,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await _enterSearchText(tester, 'Pear');
      await _tapCreateAction(tester, 'Pear');

      expect(onCreatedCalls, 0);
      expect(_item('Pear'), findsNothing);
      expect(_pickedItem('Pear'), findsNothing);
      expect(_createItem('Pear'), findsOneWidget);
    });
  });

  group('Overlay Lifecycle', () {
    testWidgets('rebinds overlay callbacks when overlay options change',
        (WidgetTester tester) async {
      final controller = TextEditingController();
      final firstOptions = OverlayOptions<String>();
      final secondOptions = OverlayOptions<String>();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(controller: controller),
          items: const ['Apple', 'Banana'],
          itemsVisibility: ShowedItemsVisibility.onType,
          overlay: true,
          overlayOptions: firstOptions,
        ),
      );
      await tester.pumpAndSettle();

      expect(firstOptions.showOverlay, isNotNull);
      expect(firstOptions.closeOverlay, isNotNull);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(controller: controller),
          items: const ['Apple', 'Banana'],
          itemsVisibility: ShowedItemsVisibility.onType,
          overlay: true,
          overlayOptions: secondOptions,
        ),
      );
      await tester.pumpAndSettle();

      expect(firstOptions.showOverlay, isNull);
      expect(firstOptions.closeOverlay, isNull);
      expect(secondOptions.showOverlay, isNotNull);
      expect(secondOptions.closeOverlay, isNotNull);
    });

    testWidgets('switching into overlay mode does not throw and keeps query',
        (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Ban');
      final overlayOptions = OverlayOptions<String>();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(controller: controller),
          items: const ['Apple', 'Banana'],
          itemsVisibility: ShowedItemsVisibility.onType,
        ),
      );

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(controller: controller),
          items: const ['Apple', 'Banana'],
          itemsVisibility: ShowedItemsVisibility.onType,
          overlay: true,
          overlayOptions: overlayOptions,
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(overlayOptions.showOverlay, isNotNull);

      overlayOptions.showOverlay!.call();
      await tester.pumpAndSettle();

      expect(_item('Apple'), findsNothing);
      expect(_item('Banana'), findsOneWidget);
    });

    testWidgets('clears overlay callbacks when unmounted',
        (WidgetTester tester) async {
      final overlayOptions = OverlayOptions<String>();

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: const TextField(),
          items: const ['Apple'],
          itemsVisibility: ShowedItemsVisibility.onType,
          overlay: true,
          overlayOptions: overlayOptions,
        ),
      );
      await tester.pumpAndSettle();

      expect(overlayOptions.showOverlay, isNotNull);
      expect(overlayOptions.closeOverlay, isNotNull);

      await tester.pumpWidget(
        const MaterialApp(
          home: SizedBox.shrink(),
        ),
      );
      await tester.pumpAndSettle();

      expect(overlayOptions.showOverlay, isNull);
      expect(overlayOptions.closeOverlay, isNull);
    });

    testWidgets('switching out of overlay mode clears overlay callbacks',
        (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Ban');
      final overlayOptions = OverlayOptions<String>();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(controller: controller),
          items: const ['Apple', 'Banana'],
          itemsVisibility: ShowedItemsVisibility.onType,
          overlay: true,
          overlayOptions: overlayOptions,
        ),
      );
      await tester.pumpAndSettle();

      expect(overlayOptions.showOverlay, isNotNull);
      expect(overlayOptions.closeOverlay, isNotNull);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(controller: controller),
          items: const ['Apple', 'Banana'],
          itemsVisibility: ShowedItemsVisibility.onType,
        ),
      );
      await tester.pumpAndSettle();

      expect(overlayOptions.showOverlay, isNull);
      expect(overlayOptions.closeOverlay, isNull);
      expect(_item('Banana'), findsOneWidget);
    });

    testWidgets('swapping overlay focus nodes detaches old listener',
        (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Ban');
      final firstFocusNode = FocusNode();
      final secondFocusNode = FocusNode();
      final overlayOptions = OverlayOptions<String>();
      addTearDown(controller.dispose);
      addTearDown(firstFocusNode.dispose);
      addTearDown(secondFocusNode.dispose);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(
            controller: controller,
            focusNode: firstFocusNode,
          ),
          items: const ['Apple', 'Banana'],
          itemsVisibility: ShowedItemsVisibility.onType,
          overlay: true,
          overlayOptions: overlayOptions,
        ),
      );
      await tester.pumpAndSettle();

      firstFocusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(_item('Banana'), findsOneWidget);

      overlayOptions.closeOverlay!.call();
      firstFocusNode.unfocus();
      await tester.pumpAndSettle();
      expect(_item('Banana'), findsNothing);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(
            controller: controller,
            focusNode: secondFocusNode,
          ),
          items: const ['Apple', 'Banana'],
          itemsVisibility: ShowedItemsVisibility.onType,
          overlay: true,
          overlayOptions: overlayOptions,
        ),
      );
      await tester.pumpAndSettle();

      firstFocusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(_item('Banana'), findsNothing);

      secondFocusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(_item('Banana'), findsOneWidget);
    });

    testWidgets('externally owned controller and focus node survive disposal',
        (WidgetTester tester) async {
      final controller = TextEditingController();
      final focusNode = FocusNode();
      final overlayOptions = OverlayOptions<String>();
      addTearDown(controller.dispose);
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(
        _buildSelectionApp(
          searchField: TextField(
            controller: controller,
            focusNode: focusNode,
          ),
          items: const ['Apple'],
          itemsVisibility: ShowedItemsVisibility.onType,
          overlay: true,
          overlayOptions: overlayOptions,
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        const MaterialApp(
          home: SizedBox.shrink(),
        ),
      );
      await tester.pumpAndSettle();

      expect(() => controller.addListener(() {}), returnsNormally);
      expect(() => controller.text = 'Pear', returnsNormally);
      expect(() => focusNode.addListener(() {}), returnsNormally);
    });
  });
}
