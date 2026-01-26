import 'dart:developer';

import 'package:example/constants.dart';
import 'package:flutter/material.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';

class OverlayConstructorExample extends StatelessWidget {
  const OverlayConstructorExample({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MultipleSearchController controller =
        MultipleSearchController(minCharsToShowItems: 3);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overlay Constructor',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'The results list floats over other content. Try searching!',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          MultipleSearchSelection<Country>.overlay(
            itemsVisibility: ShowedItemsVisibility.onType,
            searchField: const TextField(
              decoration: InputDecoration(
                hintText: 'Search countries (Overlay)...',
                prefixIcon: Icon(Icons.layers),
              ),
            ),
            overlayOptions: OverlayOptions(
              closeOnItemSelected: false,
              canCreateItem: true,
              createOptions: CreateOptions(
                create: (text) {
                  return Country(name: text, iso: text);
                },
                onDuplicate: (item) {
                  log('Duplicate item $item');
                },
                allowDuplicates: false,
                onCreated: (c) => log('Country ${c.name} created'),
                createBuilder: (text) => Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Create "$text"',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                pickCreated: true,
              ),
            ),
            controller: controller,
            title: const SizedBox.shrink(),
            onItemAdded: (c) {
              controller.getAllItems();
              controller.getPickedItems();
            },
            clearSearchFieldOnSelect: true,
            items: countries,
            fieldToCheck: (c) {
              return c.name;
            },
            itemBuilder: (country, index, isPicked) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Text(country.name),
              );
            },
            pickedItemBuilder: (country) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.orange.withOpacity(0.2)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  country.name,
                  style: const TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold),
                ),
              );
            },
            sortShowedItems: true,
            sortPickedItems: true,
            selectAllButton: Padding(
              padding: const EdgeInsets.all(12.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Select All',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            clearAllButton: Padding(
              padding: const EdgeInsets.all(12.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Clear All',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            caseSensitiveSearch: false,
            fuzzySearch: FuzzySearch.none,
            showSelectAllButton: true,
            maximumShowItemsHeight: 200,
          ),
          const SizedBox(height: 20),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Content below the search field.\nThe overlay should appear on top of this.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
