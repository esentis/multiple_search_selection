import 'dart:developer';

import 'package:example/constants.dart';
import 'package:flutter/material.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';

class SelectableExample extends StatelessWidget {
  const SelectableExample({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MultipleSearchController<Country> controller = MultipleSearchController(
      minCharsToShowItems: 3,
      allowDuplicateSelection: false,
      isSelectable: true,
    );
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selectable Constructor',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Items have checkboxes and can be selected/deselected.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          MultipleSearchSelection<Country>(
            searchField: TextField(
              decoration: const InputDecoration(
                hintText: 'Search countries...',
                prefixIcon: Icon(Icons.check_box),
              ),
            ),
            onSearchChanged: (text) {
              log('Text is $text');
            },
            controller: controller,
            itemsVisibility: ShowedItemsVisibility.onType,
            title: const SizedBox.shrink(),
            onItemAdded: (c) {
              controller.getAllItems();
              controller.getPickedItems();
            },
            items: countries,
            fieldToCheck: (c) {
              return c.name;
            },
            itemBuilder: (country, index, isPicked) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isPicked ? Colors.blue.shade50 : Colors.white,
                  border: Border.all(
                      color: isPicked ? Colors.blue : Colors.grey.shade200),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      isPicked
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: isPicked ? Colors.blue : Colors.grey,
                    ),
                    const SizedBox(width: 12),
                    Text(country.name),
                  ],
                ),
              );
            },
            pickedItemBuilder: (country) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.withOpacity(0.2)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  country.name,
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
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
          Center(
            child: TextButton(
              onPressed: () {
                print(controller.getPickedItems());
              },
              child: const Text('Log picked items'),
            ),
          ),
        ],
      ),
    );
  }
}
