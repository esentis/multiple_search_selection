import 'dart:developer';

import 'package:example/constants.dart';
import 'package:flutter/material.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';

class DefaultConstructorExample extends StatelessWidget {
  const DefaultConstructorExample({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MultipleSearchController<Country> controller = MultipleSearchController(
      minCharsToShowItems: 3,
      allowDuplicateSelection: false,
    );
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Default Constructor',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'This is the standard usage. Start typing to see results (min 3 chars).',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          MultipleSearchSelection<Country>(
            searchField: const TextField(
              decoration: InputDecoration(
                hintText: 'Search countries...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            onSearchChanged: (text) {
              log('Text is $text');
            },
            controller: controller,
            itemsVisibility: ShowedItemsVisibility.onType,
            title: const SizedBox.shrink(),
            onItemAdded: (c) {
              print(c);
              print('All items length ${controller.getAllItems().length}');
              print(
                  'Picked items length ${controller.getPickedItems().length}');
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.blue.withOpacity(0.1),
                      child: Text(
                        country.iso.substring(0, 1),
                        style:
                            const TextStyle(fontSize: 10, color: Colors.blue),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(country.name,
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
              );
            },
            pickedItemBuilder: (country) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.2)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  country.name,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
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
            child: ElevatedButton(
              onPressed: () {
                log(controller.getPickedItems().toString());
              },
              child: const Text('Log Picked Items'),
            ),
          ),
        ],
      ),
    );
  }
}
