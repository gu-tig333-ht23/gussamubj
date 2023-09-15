import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "home_page.dart";

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Todos",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Center(
        child: AddTodoBody(),
      ),
    );
  }
}

class AddTodoBody extends StatefulWidget {
  const AddTodoBody({super.key});

  @override
  State<AddTodoBody> createState() => _AddTodoBodyState();
}

class _AddTodoBodyState extends State<AddTodoBody> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoModel = Provider.of<TodoModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Something to do',
            border: OutlineInputBorder(),
          ),
          controller: textController,
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            if (textController.text.trim().isNotEmpty) {
              todoModel.addTodo(textController.text.trim());
              textController.clear();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text("Add",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
          ),
        ),
      ]),
    );
  }
}
