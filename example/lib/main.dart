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
        title: Text(
          'Countries',
          style: kStyleDefault.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        titlePadding: const EdgeInsets.symmetric(vertical: 10),
        searchItemTextContentPadding:
            const EdgeInsets.symmetric(horizontal: 10),
        maximumShowItemsHeight: 200,
        hintText: 'Type here to search',
        hintTextStyle: kStyleDefault.copyWith(
          fontSize: 13,
          color: Colors.grey[400],
        ),
        selectAllTextStyle: kStyleDefault,
        selectAllBackgroundColor: Colors.white,
        selectAllOnHoverBackgroundColor: Colors.blue[300],
        selectAllOnHoverTextColor: Colors.white,
        selectAllOnHoverFontWeight: FontWeight.bold,
        clearAllTextStyle: kStyleDefault.copyWith(
          color: Colors.red,
        ),
        clearAllOnHoverFontWeight: FontWeight.bold,
        clearAllOnHoverBackgroundColor: Colors.white,
        pickedItemTextStyle: kStyleDefault.copyWith(
          fontSize: 13,
        ),
        pickedItemBackgroundColor: Colors.grey[300]!.withOpacity(0.5),
        pickedItemBorderRadius: 6,
        pickedItemTextColor: Colors.black,
        showedItemTextStyle: kStyleDefault.copyWith(
          fontWeight: FontWeight.w500,
        ),
        showedItemsBackgroundColor: Colors.grey.withOpacity(0.1),
        searchItemTextStyle: kStyleDefault,
        noResultsWidget: Text(
          'No items found',
          style: kStyleDefault.copyWith(
            color: Colors.grey[400],
            fontSize: 13,
            fontWeight: FontWeight.w100,
          ),
        ),
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
