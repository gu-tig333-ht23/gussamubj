import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Todos',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.menu,
                    color: Theme.of(context).colorScheme.onPrimary),
                onPressed: () => {}),
            const SizedBox(width: 8),
          ]),
      body: Center(
        child: TodoList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: '',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
  });
  static var staticExamples = <String, bool>{
    "Enjoy learning this stuff": true,
    "Put more time into Dart": false,
    "Put more time into Flutter": false,
    "Contemplate life": false,
    "Finish TIG333": false,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView(
        children: <Widget>[
          for (var example in staticExamples.entries)
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Checkbox(
                      value: example.value,
                      onChanged: (value) => {},
                    ),
                    const SizedBox(width: 12),
                    Text(
                      example.key,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          decoration: example.value
                              ? TextDecoration.lineThrough
                              : null),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () => {},
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
