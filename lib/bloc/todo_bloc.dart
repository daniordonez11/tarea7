import 'dart:async';

import 'package:tarea7/clases/todo.dart';

class TodoBloc {
  final List<Todo> _todos = [];
  final _todoController = StreamController<List<Todo>>.broadcast();

  Stream<List<Todo>> get todoStream => _todoController.stream;

  void _updateStream() {
    _todoController.sink.add(List.unmodifiable(_todos));
  }

  void addTask(String title) {
    _todos.add(Todo(title: title));
    _updateStream();
  }

  void removeTask(int index) {
    _todos.removeAt(index);
    _updateStream();
  }

  void toggleComplete(int index) {
    _todos[index].completed = !_todos[index].completed;
    _updateStream();
  }

  void dispose() {
    _todoController.close();
  }
}
