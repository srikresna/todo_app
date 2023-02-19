import 'package:flutter/foundation.dart';
import 'package:todo/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos.where((todo) => !todo.completed).toList();

  List<Todo> get completedTodos => _todos.where((todo) => todo.completed).toList();

  void add(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void update(Todo todo) {
    final index = _todos.indexOf(todo);
    if (index != -1) {
      _todos[index] = todo;
      notifyListeners();
    }
  }

  void delete(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  void complete(Todo todo) {
    final index = _todos.indexOf(todo);
    if (index != -1) {
      _todos[index] = todo.copyWith(completed: true);
      notifyListeners();
    }
  }
}
