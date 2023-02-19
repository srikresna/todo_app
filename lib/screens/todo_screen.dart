import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/provider/todo_provider.dart';
import 'package:todo/widgets/todo_item.dart';

class TodoScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: true);
    final List<Todo> todos = todoProvider.todos;
    final List<Todo> completedTodos = todoProvider.completedTodos;

    void _addTodo() {
      if (_textEditingController.text.isNotEmpty) {
        todoProvider.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch,
          title: _textEditingController.text,
          completed: false,
        ));
        _textEditingController.clear();
      }
    }

    void _update(Todo todo) {
      todoProvider.update(todo);
    }

    void _delete(Todo todo) {
      todoProvider.delete(todo);
    }

    void _completeAll() {
      for (var todo in todos) {
        todo.completed = true;
        todoProvider.update(todo);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return TodoItem(
                  todo: todos[index],
                  onCompleted: (bool value) {
                    Todo updatedTodo = todos[index];
                    updatedTodo.completed = value;
                    _update(updatedTodo);
                  },
                  onDelete: () {
                    _delete(todos[index]);
                  },
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Completed Todos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: _completeAll,
                child: Text('Mark All Completed'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: completedTodos.length,
              itemBuilder: (context, index) {
                return TodoItem(
                  todo: completedTodos[index],
                  onCompleted: (bool value) {
                    Todo updatedTodo = completedTodos[index];
                    updatedTodo.completed = value;
                    _update(updatedTodo);
                  },
                  onDelete: () {
                    _delete(completedTodos[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add a new todo'),
                content: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Enter a task',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('CANCEL'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: Text('ADD'),
                    onPressed: () {
                      _addTodo();
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
