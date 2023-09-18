import "package:flutter/material.dart";

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
