import 'package:example/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: MultipleSearchSelection(
        items: countries, // List<String>
        fuzzySearch: FuzzySearch.jaro,
        padding: const EdgeInsets.all(20),
        itemsVisibility: ShowedItemsVisibility.alwaysOn,

        title: Text(
          'Countries',
          style: kStyleDefault.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        showSelectAllButton: true,
        titlePadding: const EdgeInsets.symmetric(vertical: 10),
        searchItemTextContentPadding:
            const EdgeInsets.symmetric(horizontal: 10),
        maximumShowItemsHeight: 200,
        onTapShowedItem: () {},
        onPickedChange: (items) {},
        onItemAdded: (item) {
          print('$item added to picked items');
        },
        onItemRemoved: (item) {
          print('$item removed from picked items');
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
