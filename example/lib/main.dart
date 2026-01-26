import 'package:example/examples/creatable_example.dart';
import 'package:example/examples/default_example.dart';
import 'package:example/examples/legacy_example.dart';
import 'package:example/examples/overlay_example.dart';
import 'package:example/examples/selectable_example.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiple Search Selection Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
        ),
      ),
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _examples = [
    const LegacyExample(),
    const DefaultConstructorExample(),
    const CreatableConstructorExample(),
    const OverlayConstructorExample(),
    const SelectableExample(),
  ];

  final List<String> _titles = [
    'Legacy',
    'Default',
    'Creatable',
    'Overlay',
    'Selectable',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _examples
            .map((e) => Center(child: SingleChildScrollView(child: e)))
            .toList(),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'Legacy',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_box_outline_blank),
            label: 'Default',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: 'Creatable',
          ),
          NavigationDestination(
            icon: Icon(Icons.layers_outlined),
            label: 'Overlay',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_box),
            label: 'Selectable',
          ),
        ],
      ),
    );
  }
}
