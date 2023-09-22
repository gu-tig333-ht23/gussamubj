import "package:flutter/material.dart";
import 'dart:convert';
import "package:http/http.dart" as http;
import "todo.dart";

class TodoModel extends ChangeNotifier {
  var baseUrl = "todoapp-api.apps.k8s.gu.se";
  var apiKey = "e6506772-3956-4bad-8d5f-f61643f3086b";
  var header = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };
  var todos = <Todo>[];

  // GET
  Future<void> getTodos() async {
    final response =
        await http.get(Uri.https(baseUrl, "/todos", {"key": apiKey}));

    refreshLocalTodos(response);
  }

  // POST
  Future<void> addTodo(String title) async {
    var todo = Todo.newTodo(title);

    final response = await http.post(
        Uri.https(baseUrl, "/todos", {"key": apiKey}),
        headers: header,
        body: todo.toJson());

    refreshLocalTodos(response);
  }

  // PUT
  Future<void> updateTodo(Todo todo) async {
    todo.done = !todo.done;

    final response = await http.put(
        Uri.https(baseUrl, "/todos/${todo.id}", {"key": apiKey}),
        headers: header,
        body: todo.toJson());

    refreshLocalTodos(response);
  }

  // DELETE
  Future<void> removeTodo(Todo todo) async {
    final response = await http.delete(
        Uri.https(baseUrl, "/todos/${todo.id}", {"key": apiKey}),
        headers: header,
        body: todo.toJson());

    refreshLocalTodos(response);
  }

  // Uppdaterar lokala listan `todos` och triggar rebuilds med notifylisteners
  void refreshLocalTodos(response) {
    List<dynamic> responseBodyDecoded = jsonDecode(response.body);
    todos =
        responseBodyDecoded.map((item) => Todo.fromDecodedJson(item)).toList();
    notifyListeners();
  }

  // Returnerar filtrerad `todos`
  List<Todo> get todosFiltered {
    switch (filterStatus) {
      case FilterChoice.all:
        return todos;
      case FilterChoice.done:
        return todos.where((todo) => todo.done).toList();
      case FilterChoice.undone:
        return todos.where((todo) => !todo.done).toList();
    }
  }

  void updateFilter(choice) {
    filterStatus = choice;
    notifyListeners();
  }

  var filterStatus = FilterChoice.all;
}

enum FilterChoice { all, done, undone }
