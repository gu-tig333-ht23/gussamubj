import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "add_todo.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToAddTodo() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddTodo()));
    }

    final todoModel = context.watch<TodoModel>();

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
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddTodo,
        tooltip: '',
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
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView.builder(
        itemCount: todoModel.todosFiltered.length,
        itemBuilder: (context, index) {
          var todoEntry = todoModel.todosFiltered.entries.elementAt(index);
          return Card(
            key: ValueKey(todoEntry.key),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Checkbox(
                    value: todoEntry.value,
                    onChanged: (value) =>
                        {todoModel.updateTodo(todoEntry.key, value)},
                  ),
                  const SizedBox(width: 12),
                  Text(
                    todoEntry.key,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        decoration: todoEntry.value
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () => {todoModel.removeTodo(todoEntry.key)},
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

class TodoModel extends ChangeNotifier {
  var todos = <String, bool>{
    "Enjoy learning this stuff": true,
    "Put more time into Dart": false,
    "Put more time into Flutter": false,
    "Contemplate life": false,
    "Finish TIG333": false,
  };

  Map<String, bool> get todosFiltered {
    switch (filterStatus) {
      case FilterChoice.all:
        return todos;
      case FilterChoice.done:
        return Map.fromEntries(todos.entries.where((key) => key.value == true));
      case FilterChoice.undone:
        return Map.fromEntries(
            todos.entries.where((key) => key.value == false));
    }
  }

  void addTodo(String todo) {
    todos[todo] = false;
    notifyListeners();
  }

  void removeTodo(String todo) {
    todos.remove(todo);
    notifyListeners();
  }

  void updateTodo(String todo, value) {
    todos[todo] = value;
    notifyListeners();
  }

  void updateFilter(choice) {
    filterStatus = choice;
    notifyListeners();
  }

  var filterStatus = FilterChoice.all;
}

enum FilterChoice { all, done, undone }
