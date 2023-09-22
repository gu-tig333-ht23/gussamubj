import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "page_home.dart";
import "todo_model.dart";

void main() async {
  final todoModel = TodoModel();
  await todoModel.getTodos();

  runApp(
    ChangeNotifierProvider(
      create: (context) => todoModel,
      child: MyApp(),
    ),
  );
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
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
