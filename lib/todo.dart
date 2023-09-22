import "dart:convert";

class Todo {
  String? id;
  String title;
  bool done;

  // Skapa ny todo utan ID
  Todo.newTodo(this.title)
      : id = null,
        done = false;

  // Återskapa todo baserat på svar från api
  Todo.fromDecodedJson(Map<String, dynamic> todoFromApi)
      : id = todoFromApi['id'],
        title = todoFromApi['title'],
        done = todoFromApi['done'];

  // Instansmetod som konverterar `this` till en json-sträng
  String toJson() {
    Map<String, dynamic> map = {
      if (id != null) 'id': id,
      'title': title,
      'done': done,
    };
    return jsonEncode(map);
  }
}
