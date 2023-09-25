import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "page_add_todo.dart";
import "todo_model.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToAddTodo() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddTodo()));
    }

    final todoModel = context.watch<TodoModel>();

    // Root på startsidan
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
          actions: <Widget>[
            // Meny för att välja filter
            PopupMenuButton<FilterChoice>(
              icon: Icon(Icons.menu,
                  color: Theme.of(context).colorScheme.onPrimary),
              tooltip: "Filter",
              onSelected: (FilterChoice choice) {
                todoModel.updateFilter(choice);
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<FilterChoice>>[
                const PopupMenuItem<FilterChoice>(
                  value: FilterChoice.all,
                  child: Text("All"),
                ),
                const PopupMenuItem<FilterChoice>(
                  value: FilterChoice.done,
                  child: Text("Done"),
                ),
                const PopupMenuItem<FilterChoice>(
                  value: FilterChoice.undone,
                  child: Text("Undone"),
                ),
              ],
            ),
            const SizedBox(width: 8),
          ]),
      body: Center(
        child: TodoList(),
      ),
      // Knapp i nedre högra hörnet på startsidan som navigerar till den andra sidan
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddTodo,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final todoModel = Provider.of<TodoModel>(context);
    todoModel.getTodos;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView.builder(
        // Skapar ett card för varje objekt i den filtrerade TodoModel.todos
        itemCount: todoModel.todosFiltered.length,
        itemBuilder: (context, index) {
          var todoEntry = todoModel.todosFiltered.elementAt(index);
          return Card(
            key: ValueKey(todoEntry.title),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Checkbox(
                    value: todoEntry.done,
                    onChanged: (_) => {todoModel.updateTodo(todoEntry)},
                  ),
                  const SizedBox(width: 12),
                  Text(
                    todoEntry.title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        decoration:
                            todoEntry.done ? TextDecoration.lineThrough : null),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () => {todoModel.removeTodo(todoEntry)},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
