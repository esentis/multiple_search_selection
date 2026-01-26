import 'dart:developer';

import 'package:example/constants.dart';
import 'package:flutter/material.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';

class CreatableConstructorExample extends StatelessWidget {
  const CreatableConstructorExample({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MultipleSearchController controller = MultipleSearchController();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Creatable Constructor',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Type something that doesn\'t exist to create a new item.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          MultipleSearchSelection<Country>.creatable(
            itemsVisibility: ShowedItemsVisibility.onType,
            searchField: const TextField(
              decoration: InputDecoration(
                hintText: 'Search or create countries...',
                prefixIcon: Icon(Icons.add_circle_outline),
              ),
            ),
            createOptions: CreateOptions(
              create: (text) {
                return Country(name: text, iso: text);
              },
              validator: (country) {
                return country.name.length > 2;
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
                  child: Row(
                    children: [
                      const Icon(Icons.add, color: Colors.green),
                      const SizedBox(width: 8),
                      Text('Create "$text"',
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              pickCreated: true,
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
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.purple.withOpacity(0.2)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  country.name,
                  style: const TextStyle(
                      color: Colors.purple, fontWeight: FontWeight.bold),
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
          Center(
            child: TextButton(
              onPressed: () {
                print(controller.getPickedItems());
                print(controller.getPickedItems().isEmpty);
              },
              child: const Text('Log picked items'),
            ),
          ),
        ],
      ),
    );
  }
}
