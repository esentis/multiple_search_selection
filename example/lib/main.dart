import 'package:example/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:multiple_search_selection/helpers/overlay_options.dart';
import 'package:multiple_search_selection/helpers/search_controller.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiple Search Selection Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      home: const MyHomePage(title: 'Multiple Search Selection Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MultipleSearchController controller = MultipleSearchController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            MultipleSearchSelection<Country>.overlay(
              overlayOptions: const OverlayOptions(
                closeOnFocusLost: false,
              ),
              controller: controller,
              title: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Countries',
                  style: kStyleDefault.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onItemAdded: (c) {
                controller.getAllItems();
                controller.getPickedItems();
              },
              clearSearchFieldOnSelect: true,
              showClearSearchFieldButton: true,
              // createOptions: CreateOptions(
              //   createItem: (text) {
              //     return Country(name: text, iso: text);
              //   },
              //   onDuplicateItem: (item) {
              //     print('Duplicate item $item');
              //   },
              //   allowDuplicates: false,
              //   onItemCreated: (c) => print('Country ${c.name} created'),
              //   createItemBuilder: (text) => Align(
              //     alignment: Alignment.centerLeft,
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text('Create "$text"'),
              //     ),
              //   ),
              //   pickCreatedItem: true,
              // ),
              items: countries, // List<Country>
              fieldToCheck: (c) {
                return c.name;
              },
              itemBuilder: (country, index) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 12,
                      ),
                      child: Text(country.name),
                    ),
                  ),
                );
              },
              pickedItemBuilder: (country) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[400]!),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(country.name),
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
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Select All',
                      style: kStyleDefault,
                    ),
                  ),
                ),
              ),
              clearAllButton: Padding(
                padding: const EdgeInsets.all(12.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Clear All',
                      style: kStyleDefault,
                    ),
                  ),
                ),
              ),
              caseSensitiveSearch: false,
              fuzzySearch: FuzzySearch.none,
              showSelectAllButton: true,
              maximumShowItemsHeight: 200,
            ),
            Placeholder(
              fallbackHeight: 900,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
